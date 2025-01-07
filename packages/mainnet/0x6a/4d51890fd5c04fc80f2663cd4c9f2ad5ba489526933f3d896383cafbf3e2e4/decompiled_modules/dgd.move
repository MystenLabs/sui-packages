module 0x6a4d51890fd5c04fc80f2663cd4c9f2ad5ba489526933f3d896383cafbf3e2e4::dgd {
    struct DGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGD>(arg0, 6, b"DGD", b"DogeDollars", b"DogeDollars (DGD) is a fun and engaging meme coin inspired by the legendary Dogecoin. Designed to capture the playful spirit of the crypto community, DogeDollars aims to bring joy and financial opportunities to its holders. With its easy-to-remember symbol and strong connection to the beloved Doge meme, DogeDollars is set to become the next big thing in the world of meme coins. Join the DogeDollars community and be part of the laughter and excitement!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/55809905_fcc1_4d17_ae3f_23254fe7a6cc_853cb0384b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

