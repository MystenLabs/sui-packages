module 0x800dff68c776c379a8a4e133c8713874a2624d1a4d70a63c9d4f8b08bc9cca4d::boca {
    struct BOCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOCA>(arg0, 6, b"BOCA", b"Book of Cat", b"BOOK OF CAT : an experimental project poised to redefine web3 culture by cat memes, decentralized storage solutions and degen shitcoin trading and gambling.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6731_30b5bc4139.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

