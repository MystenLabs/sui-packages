module 0xd7291089a5bbf02199b997a3a2fbfabb82ef649ccfb1aa024b21affd4b15f295::lka {
    struct LKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKA>(arg0, 9, b"IKA", b"IKA Token", b"Ika Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://docs.dwallet.io/img/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LKA>>(0x2::coin::mint<LKA>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LKA>>(v2);
    }

    // decompiled from Move bytecode v6
}

