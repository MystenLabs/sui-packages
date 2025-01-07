module 0x6b8f4d2c02912de812ad1a05d6975cdf8856e840181fb2981114febcd8853f60::balltze {
    struct BALLTZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLTZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLTZE>(arg0, 6, b"BALLTZE", b"BALLTZE | THE OG MEME SENSATION", b"#BALLTZE AND $DOGE ARE TWO OF THE MOST ICONIC DOGS ON THE INTERNET, OFTEN APPEARING IN MEMES SIDE BY SIDE. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rsu_DK_Ttd_400x400_e8d4e82c9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLTZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLTZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

