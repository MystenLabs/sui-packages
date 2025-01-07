module 0x531c0244fbfc08250108839dd3c5b7e8dc0b46ce57b3a9701983f7b26a3fe65d::tino {
    struct TINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINO>(arg0, 6, b"Tino", b"Tinong", b"Tinong is a fun and community-driven meme token on the Sui blockchain, designed to bring humor and engagement to the crypto space. Built for fans of lighthearted innovation, Tinong aims to create a unique blend of meme culture and blockchain technology, offering users a playful and entertaining experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e7e96534_feb9_4635_a66a_26254bb023d1_21fc76082e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

