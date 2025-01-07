module 0xec3a475f99447e1ed7a808ef1c86721972c53380319d9f4de4fb5b79a59c8b3d::pesui {
    struct PESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESUI>(arg0, 6, b"PESUI", b"Peter Griffin on SUI", b"The perfect combination of meme and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_20_01_04_4447038dcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

