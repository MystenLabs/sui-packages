module 0x828df1fd0ebbd33cc3c36245594e4a1b607a1859b074270a40786f74a312384d::dmoodeng {
    struct DMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMOODENG>(arg0, 6, b"DMOODENG", b"DARK MOODENG", b"Dark Moodeng Inspired By Famous Hippo From Thai Zoo $DMOODENG | ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_J5fq_6_D_400x400_ccc00252d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

