module 0x3a2db9ebe7a7d653b7c72fc9d30bafa7ada2c85dce58536ca77a72b5705f27e2::cds {
    struct CDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDS>(arg0, 9, b"CDS", b"CORDS", b"CORDS TOKEN is a community driven meme token built on the SUI BLOCK CHAIN. This meme token is aiming to become the biggest meme token on the SUI BLOCK CHAIN. This has a total supply of 10billion tokens and all for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f36236f5-b3dc-4118-8fd3-513ad0303416.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

