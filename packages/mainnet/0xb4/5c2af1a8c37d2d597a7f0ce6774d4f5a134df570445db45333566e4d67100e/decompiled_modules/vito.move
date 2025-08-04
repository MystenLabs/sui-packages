module 0xb45c2af1a8c37d2d597a7f0ce6774d4f5a134df570445db45333566e4d67100e::vito {
    struct VITO has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VITO>, arg1: 0x2::coin::Coin<VITO>) {
        assert!(false == false, 100);
        0x2::coin::burn<VITO>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VITO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<VITO>(0x2::coin::supply<VITO>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<VITO>>(0x2::coin::mint<VITO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VITO>(arg0, 5, b"VITO", b"VITO", b"Mr.Vito token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/1pHJj1Y5xLuFLjROr1mhKYfucB4OGszfcAFhTy5lI6c?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VITO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

