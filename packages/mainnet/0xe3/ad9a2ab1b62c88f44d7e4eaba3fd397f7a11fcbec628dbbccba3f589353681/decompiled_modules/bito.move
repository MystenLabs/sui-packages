module 0xe3ad9a2ab1b62c88f44d7e4eaba3fd397f7a11fcbec628dbbccba3f589353681::bito {
    struct BITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITO>(arg0, 6, b"BITO", b"Biggest Token", b"Biggest Token has a robust ecosystem with a wide range of ready and upcoming utilities like Biggest Mini App", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049175_9f6eaf1134.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

