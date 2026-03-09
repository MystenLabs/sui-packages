module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::fee_tier {
    struct FeeTierCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeTier has store, key {
        id: 0x2::object::UID,
        fee_rate: u64,
        tick_spacing: u32,
    }

    public fun delete(arg0: &FeeTierCap, arg1: FeeTier) {
        let FeeTier {
            id           : v0,
            fee_rate     : _,
            tick_spacing : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun create(arg0: &FeeTierCap, arg1: u64, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 1000000, 0);
        assert!(arg2 > 0 && arg2 <= 1000, 1);
        let v0 = FeeTier{
            id           : 0x2::object::new(arg3),
            fee_rate     : arg1,
            tick_spacing : arg2,
        };
        0x2::transfer::public_share_object<FeeTier>(v0);
    }

    public fun fee_rate(arg0: &FeeTier) : u64 {
        arg0.fee_rate
    }

    public fun id(arg0: &FeeTier) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeTierCap{id: 0x2::object::new(arg0)};
        let v1 = FeeTier{
            id           : 0x2::object::new(arg0),
            fee_rate     : 3000,
            tick_spacing : 60,
        };
        0x2::transfer::public_share_object<FeeTier>(v1);
        0x2::transfer::public_transfer<FeeTierCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun tick_spacing(arg0: &FeeTier) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v6
}

