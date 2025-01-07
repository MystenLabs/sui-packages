module 0x718ad077e952142777cf219f7de2327157caed956f6109a3fb57175a47c9470d::suibome {
    struct SUIBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOME>(arg0, 6, b"Suibome", b"bome", b"The suibome meme will definitely be number one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8887_43b44ffc16.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

