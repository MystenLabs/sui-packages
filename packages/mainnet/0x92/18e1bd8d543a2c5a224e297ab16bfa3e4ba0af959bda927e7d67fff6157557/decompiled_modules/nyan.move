module 0x9218e1bd8d543a2c5a224e297ab16bfa3e4ba0af959bda927e7d67fff6157557::nyan {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAN>(arg0, 9, b"NYAN", b"NYANCAT", b"Meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://preview.redd.it/nyan-cat-by-me-v0-h99irg47s54a1.jpg?width=1080&crop=smart&auto=webp&s=78d37d177c3df72689696ae4e67ff11dfe282f2b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NYAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

