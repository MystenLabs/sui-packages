module 0x647d2c6be79ab2699097ff204dfb0a385f20006b9866228f2ec9a8ca5f81b6f7::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"Wukong", b"sui wokong", b"In the world of VC meme PVP, a new spirit of resistance is born, Wukong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/title_1b3e3b7c00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

