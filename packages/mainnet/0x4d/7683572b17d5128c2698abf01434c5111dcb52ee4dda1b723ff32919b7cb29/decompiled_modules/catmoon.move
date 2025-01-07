module 0x4d7683572b17d5128c2698abf01434c5111dcb52ee4dda1b723ff32919b7cb29::catmoon {
    struct CATMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMOON>(arg0, 6, b"CATMOON", b"SCATMOON", b"Catmoon is a Kitten who was looking for new adventures on the blockchain, as he loves cryptography he was looking for a network to make his home, that`s when he found Sui and fell in love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catmoon_35fc7d467d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

