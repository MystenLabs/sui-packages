module 0x84ada3c08fe44f7bb49f84cd4822d9eef16a76780e9cc889cb79ce8af7ca2bd2::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GHOST", b"Ghost of Sui", b"$GHOST drifts through the Sui Network unseen, making its presence felt in mysterious ways. Light as air, its here one moment and gone the next. Boo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_69_2128082e39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

