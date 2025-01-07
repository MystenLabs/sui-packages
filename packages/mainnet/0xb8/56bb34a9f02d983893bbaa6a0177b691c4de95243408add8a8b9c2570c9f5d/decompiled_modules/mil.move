module 0xb856bb34a9f02d983893bbaa6a0177b691c4de95243408add8a8b9c2570c9f5d::mil {
    struct MIL has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIL>, arg1: 0x2::coin::Coin<MIL>) {
        assert!(false == false, 100);
        0x2::coin::burn<MIL>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<MIL>(0x2::coin::supply<MIL>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<MIL>>(0x2::coin::mint<MIL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIL>(arg0, 6, b"MIL", b"Mila", x"4d696c6120746f6b656e20e29da4efb88fe29da4efb88fe29da4efb88fe29da4efb88fe29da4efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/fFTsOdVhtZuVQyC6jbJ00-OZYsFaY8pgbdsTa-rx63g?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

