module 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::funding_rate {
    struct MaxAllowedFRUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        value: u128,
    }

    struct GlobalIndexUpdate has copy, drop {
        id: 0x2::object::ID,
        index: FundingIndex,
    }

    struct FundingRateUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        rate: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number,
        window: u64,
        minApplicationTime: u64,
    }

    struct FundingIndex has copy, drop, store {
        value: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number,
        timestamp: u64,
    }

    struct FundingRate has copy, drop, store {
        startTime: u64,
        maxFunding: u128,
        window: u64,
        rate: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number,
        index: FundingIndex,
    }

    public fun are_indexes_equal(arg0: FundingIndex, arg1: FundingIndex) : bool {
        arg0.timestamp == arg1.timestamp
    }

    public fun compute_new_global_index(arg0: &0x2::clock::Clock, arg1: FundingRate, arg2: u128) : FundingIndex {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = if (v0 > arg1.index.timestamp) {
            ((v0 - arg1.index.timestamp) as u128)
        } else {
            0
        };
        if (v1 > 0) {
            arg1.index.value = 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::add(arg1.index.value, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::from(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_mul(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::value(arg1.rate) * v1, arg2), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::sign(arg1.rate)));
            arg1.index.timestamp = v0;
        };
        arg1.index
    }

    fun expected_funding_window(arg0: FundingRate, arg1: u64) : u64 {
        if (arg1 < arg0.startTime) {
            0
        } else {
            (arg1 - arg0.startTime) / 3600000 + 1
        }
    }

    public fun index(arg0: FundingRate) : FundingIndex {
        arg0.index
    }

    public fun index_value(arg0: FundingIndex) : 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number {
        arg0.value
    }

    public(friend) fun initialize(arg0: u64, arg1: u128) : FundingRate {
        FundingRate{
            startTime  : arg0,
            maxFunding : arg1,
            window     : 0,
            rate       : 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::new(),
            index      : initialize_index(arg0),
        }
    }

    public fun initialize_index(arg0: u64) : FundingIndex {
        FundingIndex{
            value     : 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::new(),
            timestamp : arg0,
        }
    }

    public fun rate(arg0: FundingRate) : 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::Number {
        arg0.rate
    }

    public(friend) fun set_funding_rate(arg0: &0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::roles::CapabilitiesSafe, arg1: &0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::roles::FundingRateCap, arg2: &mut FundingRate, arg3: u128, arg4: bool, arg5: u64, arg6: 0x2::object::ID) {
        0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::roles::check_funding_rate_operator_validity(arg0, arg1);
        let v0 = expected_funding_window(*arg2, arg5);
        assert!(v0 > 1, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::funding_rate_can_not_be_set_for_zeroth_window());
        assert!(arg2.window < v0 - 1, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::funding_rate_for_window_already_set());
        arg2.rate = 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::from(arg3 / (3600000 as u128), arg4);
        arg2.window = v0 - 1;
        let v1 = FundingRateUpdateEvent{
            id                 : arg6,
            rate               : arg2.rate,
            window             : arg2.window,
            minApplicationTime : v0 * 3600000 + arg2.startTime - arg5,
        };
        0x2::event::emit<FundingRateUpdateEvent>(v1);
    }

    public(friend) fun set_global_index(arg0: &mut FundingRate, arg1: FundingIndex, arg2: 0x2::object::ID) {
        if (arg0.index.timestamp != arg1.timestamp) {
            arg0.index = arg1;
            let v0 = GlobalIndexUpdate{
                id    : arg2,
                index : arg1,
            };
            0x2::event::emit<GlobalIndexUpdate>(v0);
        };
    }

    public(friend) fun set_max_allowed_funding_rate(arg0: &mut FundingRate, arg1: u128, arg2: 0x2::object::ID) {
        assert!(arg1 <= 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_uint(), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::error::can_not_be_greater_than_hundred_percent());
        arg0.maxFunding = arg1;
        let v0 = MaxAllowedFRUpdateEvent{
            id    : arg2,
            value : arg1,
        };
        0x2::event::emit<MaxAllowedFRUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

