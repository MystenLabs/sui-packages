module 0xed89267a43734d18b4cc30e9e1e70ab3f591ad1cf307c7b4fe6aedbf0f37fd68::okj {
    struct OKJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKJ>(arg0, 6, b"OKJ", b"oikjsd", b"oikjsdoikjsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic22sbi7summ5i4f5eavo3xfao67pdfybe5d3cokzo3azn2iwd24i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OKJ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

