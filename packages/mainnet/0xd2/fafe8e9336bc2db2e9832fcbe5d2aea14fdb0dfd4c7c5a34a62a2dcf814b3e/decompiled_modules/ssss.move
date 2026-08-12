module 0xd2fafe8e9336bc2db2e9832fcbe5d2aea14fdb0dfd4c7c5a34a62a2dcf814b3e::ssss {
    struct SSSS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSSS>, arg1: 0x2::coin::Coin<SSSS>) {
        0x2::coin::burn<SSSS>(arg0, arg1);
    }

    fun init(arg0: SSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSS>(arg0, 9, b"SSSS", b"SSSS", b"Custom SUI Token: SSSS", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSSS>(&mut v2, 54454000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSSS>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SSSS>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSSS>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

