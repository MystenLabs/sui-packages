module 0x11b31fee882d02aadf8fa59dfc16152cab408ad5c0c8e5cf66af6ce2aaa5ed40::suimeocat {
    struct SUIMEOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEOCAT>(arg0, 9, b"SUIMEOCAT", b"Suimeo cat", b"Rizz cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c6ff925-088a-4676-be40-c35c3b298992.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

