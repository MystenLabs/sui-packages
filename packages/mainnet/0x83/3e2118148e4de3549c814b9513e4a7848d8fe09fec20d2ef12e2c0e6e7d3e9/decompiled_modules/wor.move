module 0x833e2118148e4de3549c814b9513e4a7848d8fe09fec20d2ef12e2c0e6e7d3e9::wor {
    struct WOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WOR>(arg0, 6, b"WOR", b"WOr by SuiAI", b"WOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cong_cu_anh_che_meme_moi_nhat_1456_232_f08aa366b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

