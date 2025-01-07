module 0xd2a8d0e6f688e44c0426be315e339b2539092550f64a35cc690f13e34c7ec38e::moco {
    struct MOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCO>(arg0, 6, b"Moco", b"Suimoco", b"SUIMOCO is a Puppy who was looking for new adventures on the blockchain. As he loves cryptography, he was searching for a network to call home, and thats when he found Sui and fell in love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000366_4867f1e381.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

