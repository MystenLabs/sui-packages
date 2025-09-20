module 0xd61079b94b1b2395c723a30e7271833e8d59e5d526869a5bac76b04eeb4be3e2::blv {
    struct BLV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLV>(arg0, 6, b"BLV", b"Believe", b"Believe in Sui Trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibifrkdpxbz26v44laxm7bnl7q6rwxaxsyx36szorf2jc5ch4rbay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

