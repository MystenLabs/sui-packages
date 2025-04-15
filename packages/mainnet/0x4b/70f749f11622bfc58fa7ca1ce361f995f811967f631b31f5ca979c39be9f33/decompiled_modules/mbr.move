module 0x4b70f749f11622bfc58fa7ca1ce361f995f811967f631b31f5ca979c39be9f33::mbr {
    struct MBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBR>(arg0, 6, b"MBR", b"Moonbarak CTO", b"Moonbarak - the blinged-out king on SUI, rolling into Sui Basecamp 2025 with a treasure chest of SUI! We're the trolliest memecoin, mixing Dubai's golden vibes with blockchain chaos. Join the kingdom, hodl tight, and watch Moonbarak reign supreme - from the desert to the moon, habibi!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeic7sbtwtsrxnollinuvftlxdwgkm6ois334jowtxdygl33rk22dga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

