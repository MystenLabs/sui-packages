module 0xe90c56abc95690c6374d7dce3dcea77d643464e4eacd7824960787e05b17d5a6::xxxxxxxxxx {
    struct XXXXXXXXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXXXXXXXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXXXXXXXXX>(arg0, 6, b"XXXXXXXXXX", b"XXXXXXXXX", b"XXXXXXXXXXXXXXXXX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/60ba45cdbfb8afc79aad40fb_L86xy_LF_4_400x400_695f3fbe36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXXXXXXXXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXXXXXXXXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

