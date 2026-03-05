module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate {
    struct MaxAllowedFRUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        value: u128,
    }

    struct GlobalIndexUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        index: FundingIndex,
    }

    struct FundingRateUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        rate: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        window: u64,
        min_application_time: u64,
    }

    struct FundingIndex has copy, drop, store {
        value: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        timestamp: u64,
    }

    struct FundingRate has copy, drop, store {
        start_time: u64,
        max_funding: u128,
        window: u64,
        rate: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        index: FundingIndex,
    }

    public(friend) fun are_indexes_equal(arg0: FundingIndex, arg1: FundingIndex) : bool {
        arg0.timestamp == arg1.timestamp
    }

    public(friend) fun compute_new_global_index(arg0: &0x2::clock::Clock, arg1: FundingRate, arg2: u128) : FundingIndex {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = if (v0 > arg1.index.timestamp) {
            ((v0 - arg1.index.timestamp) as u128)
        } else {
            0
        };
        if (v1 > 0) {
            let v2 = if (v1 < (3600000 as u128)) {
                1
            } else {
                v1 / (3600000 as u128)
            };
            arg1.index.value = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add(arg1.index.value, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(arg1.rate) * v2, arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sign(arg1.rate)));
            arg1.index.timestamp = v0;
        };
        arg1.index
    }

    fun expected_funding_window(arg0: FundingRate, arg1: u64) : u64 {
        if (arg1 < arg0.start_time) {
            0
        } else {
            (arg1 - arg0.start_time) / 3600000 + 1
        }
    }

    public(friend) fun index(arg0: FundingRate) : FundingIndex {
        arg0.index
    }

    public(friend) fun index_timestamp(arg0: FundingIndex) : u64 {
        arg0.timestamp
    }

    public(friend) fun index_value(arg0: FundingIndex) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        arg0.value
    }

    public(friend) fun initialize(arg0: u64, arg1: u128) : FundingRate {
        FundingRate{
            start_time  : arg0,
            max_funding : arg1,
            window      : 0,
            rate        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero(),
            index       : new_index(arg0),
        }
    }

    public(friend) fun new_index(arg0: u64) : FundingIndex {
        FundingIndex{
            value     : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero(),
            timestamp : arg0,
        }
    }

    public(friend) fun rate(arg0: FundingRate) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        arg0.rate
    }

    public(friend) fun set_funding_rate(arg0: &mut FundingRate, arg1: u128, arg2: bool, arg3: u64, arg4: 0x2::object::ID) {
        let v0 = expected_funding_window(*arg0, arg3);
        assert!(v0 > 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::funding_rate_can_not_be_set_for_zeroth_window());
        assert!(arg0.window < v0 - 1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::funding_rate_for_window_already_set());
        assert!(arg1 <= arg0.max_funding, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::greater_than_max_allowed_funding());
        arg0.rate = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(arg1, arg2);
        arg0.window = v0 - 1;
        let v1 = FundingRateUpdateEvent{
            id                   : arg4,
            rate                 : arg0.rate,
            window               : arg0.window,
            min_application_time : v0 * 3600000 + arg0.start_time - arg3,
        };
        0x2::event::emit<FundingRateUpdateEvent>(v1);
    }

    public(friend) fun set_global_index(arg0: &mut FundingRate, arg1: FundingIndex, arg2: 0x2::object::ID) {
        if (arg0.index.timestamp != arg1.timestamp) {
            arg0.index = arg1;
            let v0 = GlobalIndexUpdateEvent{
                id    : arg2,
                index : arg1,
            };
            0x2::event::emit<GlobalIndexUpdateEvent>(v0);
        };
    }

    public(friend) fun set_max_allowed_funding_rate(arg0: &mut FundingRate, arg1: u128, arg2: 0x2::object::ID) {
        assert!(arg1 <= 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::can_not_be_greater_than_hundred_percent());
        arg0.max_funding = arg1;
        let v0 = MaxAllowedFRUpdateEvent{
            id    : arg2,
            value : arg1,
        };
        0x2::event::emit<MaxAllowedFRUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

