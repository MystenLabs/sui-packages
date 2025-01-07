module 0xe509b93b0f25ddc4febfb2cb6d8eaccf8469a27c2b34fc91af27ec18796905d2::blkrk {
    struct BLKRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLKRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLKRK>(arg0, 6, b"BLKRK", b"$BLKRK", x"4a6f696e20506570652c20446f67652c20616e642074686520626c61636b20726f636b206f6e20616e2065706963207269646520746f20746865206d6f6f6e21204675656c6564206279206d656d6520706f77657220616e64206c61756e63686564206f6e20547572626f732046696e616e63652c2024424c4b524b20626c656e647320687970652c20636f6d6d756e6974792c20616e6420636f736d6963207969656c642d63686173696e6720706f74656e7469616c2e20526561647920746f20626c617374206f66663f204275636b6c65207570e280947468697320726f636b657420697320676f6e6e6120626520696e73616e6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731491046394.55")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLKRK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLKRK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

