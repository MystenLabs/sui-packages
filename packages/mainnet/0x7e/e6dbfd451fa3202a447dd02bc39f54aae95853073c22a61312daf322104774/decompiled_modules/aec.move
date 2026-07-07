module 0x7ee6dbfd451fa3202a447dd02bc39f54aae95853073c22a61312daf322104774::aec {
    struct AEC has drop {
        dummy_field: bool,
    }

    struct AECAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FixedSupply has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<AEC>,
    }

    fun init(arg0: AEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEC>(arg0, 6, b"AEC", b"Asset from Everyday Commerce", b"AEC is the world's first consumer-driven digital asset backed by everyday economic activity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.shuzirenminbi.org/f2c-static/img/token/aec.png")), arg1);
        let v2 = v0;
        let v3 = FixedSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<AEC>(v2),
        };
        let v4 = AECAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AEC>>(v1);
        0x2::transfer::freeze_object<FixedSupply>(v3);
        0x2::transfer::public_transfer<AECAdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<AEC>>(0x2::coin::mint<AEC>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun total_supply(arg0: &FixedSupply) : u64 {
        0x2::balance::supply_value<AEC>(&arg0.supply)
    }

    // decompiled from Move bytecode v7
}

