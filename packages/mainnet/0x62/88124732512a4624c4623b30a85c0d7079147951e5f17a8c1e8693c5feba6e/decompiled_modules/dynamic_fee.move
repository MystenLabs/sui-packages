module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee {
    struct DynamicFee has store, key {
        id: 0x2::object::UID,
        tick_spacing: u32,
        lp_fee: u64,
        fee_mcaps: vector<u64>,
        creator_fee_rates: vector<u64>,
        protocol_fee_rates: vector<u64>,
    }

    struct DynamicFeeCap has store, key {
        id: 0x2::object::UID,
    }

    public fun apply_fee(arg0: &DynamicFee, arg1: u64, arg2: u64) : u64 {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(arg1, arg2, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::swap_math::fee_rate_denominator())
    }

    public fun get_creator_protocol_rate(arg0: &DynamicFee, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 3000;
        let v2 = 7000;
        while (v0 < 0x1::vector::length<u64>(&arg0.fee_mcaps)) {
            if (arg1 <= *0x1::vector::borrow<u64>(&arg0.fee_mcaps, v0)) {
                break
            };
            v1 = *0x1::vector::borrow<u64>(&arg0.creator_fee_rates, v0);
            v2 = *0x1::vector::borrow<u64>(&arg0.protocol_fee_rates, v0);
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    public fun id(arg0: &DynamicFee) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 100000);
        0x1::vector::push_back<u64>(&mut v1, 3000);
        0x1::vector::push_back<u64>(&mut v2, 7000);
        0x1::vector::push_back<u64>(&mut v0, 500000);
        0x1::vector::push_back<u64>(&mut v1, 4000);
        0x1::vector::push_back<u64>(&mut v2, 6000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v1, 4000);
        0x1::vector::push_back<u64>(&mut v2, 5000);
        0x1::vector::push_back<u64>(&mut v0, 5000000);
        0x1::vector::push_back<u64>(&mut v1, 5000);
        0x1::vector::push_back<u64>(&mut v2, 4000);
        0x1::vector::push_back<u64>(&mut v0, 10000000);
        0x1::vector::push_back<u64>(&mut v1, 5000);
        0x1::vector::push_back<u64>(&mut v2, 3000);
        let v3 = DynamicFee{
            id                 : 0x2::object::new(arg0),
            tick_spacing       : 40,
            lp_fee             : 2000,
            fee_mcaps          : v0,
            creator_fee_rates  : v1,
            protocol_fee_rates : v2,
        };
        let v4 = DynamicFeeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<DynamicFee>(v3);
        0x2::transfer::public_transfer<DynamicFeeCap>(v4, 0x2::tx_context::sender(arg0));
    }

    public fun lp_fee(arg0: &DynamicFee) : u64 {
        arg0.lp_fee
    }

    public fun tick_spacing(arg0: &DynamicFee) : u32 {
        arg0.tick_spacing
    }

    public fun update_fee_rates(arg0: &DynamicFeeCap, arg1: &mut DynamicFee, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>) {
        arg1.fee_mcaps = arg2;
        arg1.creator_fee_rates = arg3;
        arg1.protocol_fee_rates = arg4;
    }

    public fun update_lp_rate(arg0: &DynamicFeeCap, arg1: &mut DynamicFee, arg2: u32, arg3: u64) {
        arg1.tick_spacing = arg2;
        arg1.lp_fee = arg3;
    }

    // decompiled from Move bytecode v6
}

