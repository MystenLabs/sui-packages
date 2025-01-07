module 0x729d4726118af49fa0883e81c1328bca9d116883486165dc614027bdbdca76f8::blueh {
    struct BLUEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEH>(arg0, 9, b"BLUEH", b"Blue Eyed Hippo", b"blue family", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

