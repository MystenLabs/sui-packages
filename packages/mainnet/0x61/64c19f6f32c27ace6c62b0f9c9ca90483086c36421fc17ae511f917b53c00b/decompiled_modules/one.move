module 0x6164c19f6f32c27ace6c62b0f9c9ca90483086c36421fc17ae511f917b53c00b::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 6, b"ONE", b"1", x"536f6369616c204d656d65204578706572696d656e74206f6e205375690a5a65726f20486f6c64696e672028446576290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731279056920.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

