module 0xe44a4ad428d6429008bd51f84dd90a0fe3b001c15a1591bef27d0d38f9e98db6::dolfm {
    struct DOLFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLFM>(arg0, 6, b"DOLFM", b"DOLF Marketing", x"4e6f626f647920697320676f696e6720746f2073746f70207468652024444f4c462c206a6f696e2074686520636f6d6d756e69747920616e6420626520612070617274206f6620736f6d657468696e67207370656369616c21200a4f472043413a203078646632626532383037373039666566386337643338383431626135343634356561663030343866343130366531613032323339626633303339373166663264613a3a646f6c663a3a444f4c460a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Resized_Dolf_5b2b80387a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

