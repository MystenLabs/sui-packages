module 0xa30922153f0e818ddddd4043ac6fd397ef3958271128e3e9d43429e4a86b6e11::hive_gems {
    struct HiveGemKraftCap has store, key {
        id: 0x2::object::UID,
        krafted_total: u64,
    }

    struct HiveGems has store {
        value: u64,
    }

    struct HiveGemsBurnt has copy, drop {
        value: u64,
    }

    public fun burn(arg0: HiveGems) {
        let HiveGems { value: v0 } = arg0;
        let v1 = HiveGemsBurnt{value: v0};
        0x2::event::emit<HiveGemsBurnt>(v1);
    }

    public fun destroy_zero(arg0: HiveGems) {
        assert!(arg0.value == 0, 0);
        let HiveGems {  } = arg0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveGemKraftCap{
            id            : 0x2::object::new(arg0),
            krafted_total : 0,
        };
        0x2::transfer::transfer<HiveGemKraftCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun join(arg0: &mut HiveGems, arg1: HiveGems) : u64 {
        let HiveGems { value: v0 } = arg1;
        arg0.value = arg0.value + v0;
        arg0.value
    }

    public fun kraft_hive_gems(arg0: &mut HiveGemKraftCap, arg1: u64) : HiveGems {
        arg0.krafted_total = arg0.krafted_total + arg1;
        HiveGems{value: arg1}
    }

    public fun split(arg0: &mut HiveGems, arg1: u64) : HiveGems {
        assert!(arg0.value >= arg1, 2);
        arg0.value = arg0.value - arg1;
        HiveGems{value: arg1}
    }

    public fun total_cap_id(arg0: &HiveGemKraftCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun total_krafted_by_cap(arg0: &HiveGemKraftCap) : u64 {
        arg0.krafted_total
    }

    public fun value(arg0: &HiveGems) : u64 {
        arg0.value
    }

    public fun withdraw_all(arg0: &mut HiveGems) : HiveGems {
        let v0 = arg0.value;
        split(arg0, v0)
    }

    public fun zero() : HiveGems {
        HiveGems{value: 0}
    }

    // decompiled from Move bytecode v6
}

