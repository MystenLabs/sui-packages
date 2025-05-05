module 0x7b5649bfd8da1f2280b6760919cf4695f50cd04b8e351fdad18671d30ade3e4d::jntm {
    struct JNTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNTM>(arg0, 6, b"JNTM", b"iKUN", b"Born from China's iconic \"Ji Ni Tai Mei\" meme epidemic, $JNTM transforms internet absurdity into decentralized finance. We empower every \"True Fan\" to master the holy quadrivium of crypto: HODLing, Shilling, Memeing, and Celebrity Trolling.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihw7r6r7uol2undcfffvlh3n6hbrh7rqrhurftoz25xjeo3xcz7ta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JNTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

