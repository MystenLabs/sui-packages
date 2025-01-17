module 0x33eaf3e27c30ba25beee0aabf79a69026ea718d44fd3740671facce4d4830bcb::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANIME>(arg0, 6, b"ANIME", b"AniMaster by SuiAI", x"f09f8eb62041492d64726976656e206d7573696320616e64206c69766573747265616d732c20706f7765726564206279205355492773204149204167656e74e28094626f726e2066726f6d2047726f6b277320696d6167696e6174696f6e20616e642074686520737472656e677468206f6620636f6d6d756e6974792120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Animaster_Logo_5984a3b0a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANIME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

