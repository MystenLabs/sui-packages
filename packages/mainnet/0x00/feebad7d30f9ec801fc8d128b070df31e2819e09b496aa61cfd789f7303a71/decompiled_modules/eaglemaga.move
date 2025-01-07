module 0xfeebad7d30f9ec801fc8d128b070df31e2819e09b496aa61cfd789f7303a71::eaglemaga {
    struct EAGLEMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAGLEMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAGLEMAGA>(arg0, 6, b"Eaglemaga", b"Eagle maga", b"Maga again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000904604_53ab4093b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAGLEMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EAGLEMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

