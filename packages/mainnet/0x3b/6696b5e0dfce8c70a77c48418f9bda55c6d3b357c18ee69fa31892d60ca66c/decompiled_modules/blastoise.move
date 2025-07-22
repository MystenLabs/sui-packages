module 0x3b6696b5e0dfce8c70a77c48418f9bda55c6d3b357c18ee69fa31892d60ca66c::blastoise {
    struct BLASTOISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTOISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTOISE>(arg0, 6, b"BLASTOISE", b"BLASTOISE POKEMON", x"535549206d6f766573206c696b652077617465722e20426c6173746f6973652069732077617465722e200a4a75737420616e20756e6f6666696369616c206f6e2d636861696e20506f6bc3a96d6f6e2066616e20636f6d6d756e6974792e20666f72206e6f772e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwa7bg74q3kj5l2c564x2uqv3esqxhkbbtz6jb2weufywy5qtjxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTOISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLASTOISE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

