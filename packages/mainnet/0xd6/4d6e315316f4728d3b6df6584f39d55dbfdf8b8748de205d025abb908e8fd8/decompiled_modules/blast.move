module 0xd64d6e315316f4728d3b6df6584f39d55dbfdf8b8748de205d025abb908e8fd8::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 6, b"BLAST", b"Blastoise On Sui", x"535549206d6f766573206c696b652077617465722e20426c6173746f6973652069732077617465722e200a4a75737420616e20756e6f6666696369616c206f6e636861696e20506f6b656d6f6e2066616e20636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwa7bg74q3kj5l2c564x2uqv3esqxhkbbtz6jb2weufywy5qtjxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

