module 0xb9d13c17104b064e1c950e2b20f3fbe27a56fbf7e951f8a60621719a85a11f66::zelvis {
    struct ZELVIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELVIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELVIS>(arg0, 9, b"zelvis", b"Zombie Elvis", b"Just a zombie Elvis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/17008588/file/original-3e8053a172ab0e0a30002647a914c71c.jpg?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZELVIS>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELVIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZELVIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

