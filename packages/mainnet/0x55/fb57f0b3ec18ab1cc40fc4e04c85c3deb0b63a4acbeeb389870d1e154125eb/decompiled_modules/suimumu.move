module 0x55fb57f0b3ec18ab1cc40fc4e04c85c3deb0b63a4acbeeb389870d1e154125eb::suimumu {
    struct SUIMUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUMU>(arg0, 6, b"SUIMUMU", b"SMUMU", b"Mumu is a muuvement to unite everyone in crypto. Backed by number go up technology, the bull born from the meme we all know and love is here to lead the charge. Launched with the starting supply of the U.S. dollar, mutoshi and his delinquents are on a mission to dethrone the establishment and forge the ultimate decentralized currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_2aa55b26b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

