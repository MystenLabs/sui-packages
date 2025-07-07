module 0x6b0c33714d32d792d42618930cd412ff13a5074ca2f9c58e19082975d5691102::dhands {
    struct DHANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHANDS>(arg0, 6, b"DHands", b"Diamond Hands", b"Diamond Hands is a meme token that represents unwavering conviction in the face of market volatility. Inspired by the crypto community's slang, \"diamond hands\" refers to holding onto an asset despite pressure, fear, or temptation to sell. This token embodies the spirit of long-term belief and resilience, celebrating those who stay committed during both the highs and the lows. With a community-driven ethos, Diamond Hands aims to unite holders who believe in strength, patience, and the power of collective momentum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig4h7nqdwye5ca2oayk5zhtiv6capq6e66fkvscneohmdi4euugfu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHANDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DHANDS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

