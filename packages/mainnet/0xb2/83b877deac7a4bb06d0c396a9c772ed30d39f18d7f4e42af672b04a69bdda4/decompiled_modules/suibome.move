module 0xb283b877deac7a4bb06d0c396a9c772ed30d39f18d7f4e42af672b04a69bdda4::suibome {
    struct SUIBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOME>(arg0, 6, b"Suibome", b"Bome", b"Sui bome meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8887_d54942cd04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

