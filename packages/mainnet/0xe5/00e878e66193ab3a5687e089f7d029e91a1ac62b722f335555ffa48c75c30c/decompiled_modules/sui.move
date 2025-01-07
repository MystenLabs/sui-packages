module 0xe500e878e66193ab3a5687e089f7d029e91a1ac62b722f335555ffa48c75c30c::sui {
    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUI>,
    }

    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"Sui", b"Fake Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Registry{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::coin::mint_and_transfer<SUI>(&mut v2.treasury_cap, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::share_object<Registry>(v2);
    }

    // decompiled from Move bytecode v6
}

