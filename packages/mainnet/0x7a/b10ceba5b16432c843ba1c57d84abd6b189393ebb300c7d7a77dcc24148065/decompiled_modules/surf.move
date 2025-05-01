module 0x7ab10ceba5b16432c843ba1c57d84abd6b189393ebb300c7d7a77dcc24148065::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SURF>, arg1: 0x2::coin::Coin<SURF>) {
        assert!(true == false, 100);
        0x2::coin::burn<SURF>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SURF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<SURF>(0x2::coin::supply<SURF>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SURF>>(0x2::coin::mint<SURF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF>(arg0, 9, b"SURF", b"SURF", b"SURF token for the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/mNlJA3ea2RSvJJPAwrLMj6JIjuN_15Q1v_abWL075e8?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

