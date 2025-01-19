module 0x7905534476f695869b72c738d8394f6404a87ded231fca628ffcb7f2f4b9c17d::pt47 {
    struct PT47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT47>(arg0, 6, b"PT47", b"Presuident Trump 47", b"We will fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6196_a489f20e54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PT47>>(v1);
    }

    // decompiled from Move bytecode v6
}

