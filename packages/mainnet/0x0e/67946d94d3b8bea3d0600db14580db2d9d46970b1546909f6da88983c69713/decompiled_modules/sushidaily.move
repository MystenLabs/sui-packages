module 0xe67946d94d3b8bea3d0600db14580db2d9d46970b1546909f6da88983c69713::sushidaily {
    struct SUSHIDAILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHIDAILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHIDAILY>(arg0, 6, b"Sushidaily", b"SushiDaily", x"53757368696461696c79206973206e6f77206f6e205375692e0a4a6f696e2074656c656772616d206e6f7720692077696c6c2075706461746520782e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5196_93266b009e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHIDAILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSHIDAILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

