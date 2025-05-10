module 0xee5b31562003a03db3f76f7b955d44e39716ad82ba0477480b42a3d7385bf7b5::afish {
    struct AFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFISH>(arg0, 6, b"AFISH", b"Angler Fish", x"4265206c696b652074686520616e676c65726669736820626f726e20696e20746865206461726b657374207472656e636865732c20796574206361727279696e6720796f7572206f776e206c696768742e0a4c657420746f6461792062652061626f757420726973696e672e204576656e207768656e206974206665656c7320696d706f737369626c652c206576656e207768656e206e6f206f6e65207365657320796f752e0a5377696d2075707761726420616e797761792e20546865726520697320776f6e6465722077616974696e672061742074686520737572666163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihz35jwgipbffcz5a3fo3k7lxbvcblt2nhdjsi4i5ejprfxjj75dq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AFISH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

