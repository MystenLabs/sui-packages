module 0xd7b3168da052f8811ed9e5234c845e48042b2be832a4f09a53668eda92f983b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"SUIPI", b"SUIPI", b"you know why...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/mn4b6Yp.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

