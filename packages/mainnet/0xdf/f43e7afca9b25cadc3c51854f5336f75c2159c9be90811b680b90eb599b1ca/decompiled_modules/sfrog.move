module 0xdff43e7afca9b25cadc3c51854f5336f75c2159c9be90811b680b90eb599b1ca::sfrog {
    struct SFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROG>(arg0, 6, b"SFROG", b"Super Frog", b"SuperFrog Meme Token: SuperFrog is a fun, community-driven meme cryptocurrency inspired by the heroic spirit of frogs. Combining humor, creativity, and decentralization, SuperFrog aims to empower its holders while leaping into the meme token space with bold energy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/superfrog_33b21f5dbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

