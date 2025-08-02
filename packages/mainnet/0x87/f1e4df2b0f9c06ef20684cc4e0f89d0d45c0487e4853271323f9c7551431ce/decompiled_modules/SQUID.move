module 0x87f1e4df2b0f9c06ef20684cc4e0f89d0d45c0487e4853271323f9c7551431ce::SQUID {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"Squid Inu", b"SQUID", b"The ultimate meme coin inspired by the mysterious depths of the ocean. SQUID is here to ink its way into your crypto portfolio with tentacles of fun and volatility. Join the cephalopod revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/GJ2nyst01CbDMV9j1DmQR2J0eTR1quEoV7528alFFbDf46GVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, @0xbdebc33436425c9a7ca66a3b35925621c8885d16b3c741b9ca39527620462511);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

