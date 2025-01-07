module 0x274287a6dfb26a56c75dae002b44c93c3fffff3203d4f32fb929ee1314f38574::robo {
    struct ROBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBO>(arg0, 6, b"Robo", b"Robotaxi", b"https://x.com/teslanewswire/status/1844573574113161539?s=46", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7135_f197a6d18c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

