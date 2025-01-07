module 0x3b8367902913c95bee12f71438247ae3e9b5ec816b43766e46f2061b8f2f1c47::bugzy {
    struct BUGZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGZY>(arg0, 6, b"BUGZY", b"Bugzy on Sui", b"Just a chill Bunny named BUGZY on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ws_Z466pgzneg_Lews_b692321154.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

