module 0x765b92eb76c6c770de510caf35aab25f22889cc5097cf4b60ee83c192eba45d9::bkong {
    struct BKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKONG>(arg0, 6, b"BKong", b"Blue Kong Ding Dong", b"A BLUE King Kong (Ding Dong)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_074749_be3fc655bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

