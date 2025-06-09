module 0x10b479e3f46a4cac13d6a683091919d1a271c5887f88b8b7f7846091042744ab::caci {
    struct CACI has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CACI>, arg1: 0x2::coin::Coin<CACI>) {
        assert!(false == false, 100);
        0x2::coin::burn<CACI>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CACI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<CACI>(0x2::coin::supply<CACI>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<CACI>>(0x2::coin::mint<CACI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CACI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACI>(arg0, 6, b"CACI", b"CACI", b"Fight SNS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/vR1ZF8K_JHJO0sDpCoAh8_tngSr_qy1haqt3rzsDM6M?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CACI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

