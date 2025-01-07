module 0xb6b1ed3f490962329744eea5670a960718d64d326a08ad941649cf5e6504a620::tomo {
    struct TOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMO>(arg0, 6, b"TOMO", b"Tomo Cat Coin On Sui", b"The Biggest Cat Meme Sui ever! https://tomocatcoin.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/674894d2357e8af8d0c8cf69_favicon256_b688cf34e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

