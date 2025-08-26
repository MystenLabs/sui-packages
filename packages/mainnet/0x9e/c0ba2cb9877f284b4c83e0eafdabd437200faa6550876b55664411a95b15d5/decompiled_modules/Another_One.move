module 0x9ec0ba2cb9877f284b4c83e0eafdabd437200faa6550876b55664411a95b15d5::Another_One {
    struct ANOTHER_ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANOTHER_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANOTHER_ONE>(arg0, 9, b"AN1", b"Another One", b"another one here it goes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3KDPJC28TY2E0CSFF784J85.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANOTHER_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANOTHER_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

