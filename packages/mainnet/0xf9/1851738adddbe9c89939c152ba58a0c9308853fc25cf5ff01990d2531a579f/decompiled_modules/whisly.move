module 0xf91851738adddbe9c89939c152ba58a0c9308853fc25cf5ff01990d2531a579f::whisly {
    struct WHISLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISLY>(arg0, 6, b"WHISLY", b"Whisly", b"Whisly is a groundbreaking memecoin on the Sui blockchain, designed to build a strong, active, and engaged community. Our mission is to create an evolving ecosystem where users can collaborate, share ideas, and grow together. We are committed to becoming the top memecoin in the Sui ecosystem with a focus on community strength and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241122_003245_7dccb5f3ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHISLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

