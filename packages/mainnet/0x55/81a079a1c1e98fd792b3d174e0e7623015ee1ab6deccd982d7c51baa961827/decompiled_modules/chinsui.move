module 0x5581a079a1c1e98fd792b3d174e0e7623015ee1ab6deccd982d7c51baa961827::chinsui {
    struct CHINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINSUI>(arg0, 6, b"CHINSUI", b"CHINASUI", b"Zhongguo weida de jiami daibi Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chinasui_71f7fecb6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

