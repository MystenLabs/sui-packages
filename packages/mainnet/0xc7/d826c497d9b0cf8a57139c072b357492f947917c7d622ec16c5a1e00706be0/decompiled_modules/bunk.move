module 0xc7d826c497d9b0cf8a57139c072b357492f947917c7d622ec16c5a1e00706be0::bunk {
    struct BUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNK>(arg0, 6, b"Bunk", b"Sui Bunk", b"real suibunk meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmjr2np7pdun2j5zy5zsiy3sozdkbcca6nyddsoxlb64ct3vnz7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

