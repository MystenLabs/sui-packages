module 0x5abe1964c2f1d92d021ab2be84c7191f60c21a0e9d11bc7ab7a329f495a7c573::mbr {
    struct MBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBR>(arg0, 6, b"MBR", b"Moonbarak", b"Moonbarak - the blinged-out king on SUI, rolling into Sui Basecamp 2025 with a treasure chest of SUI! We're the trolliest memecoin, mixing Dubai's golden vibes with blockchain chaos. Join the kingdom, hodl tight, and watch Moonbarak reign supreme - from the desert to the moon, habibi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreid5zdjo2jbt3sdb7vb5lu43nvmtfwx4vp53zr23f7e3j5vkpbpkyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

