module 0x2f4bc613b902d4701c57c6b3f7a1b7fa71c4e00c1987512bf597591182f43652::tmatesui {
    struct TMATESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMATESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMATESUI>(arg0, 6, b"TMATESUI", b"TMATE ON SUI", b"FRIST ALGO BOT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tima_logo_01_fdeac24d51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMATESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMATESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

