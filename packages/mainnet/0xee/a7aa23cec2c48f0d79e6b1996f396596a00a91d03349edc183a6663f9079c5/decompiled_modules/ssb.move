module 0xeea7aa23cec2c48f0d79e6b1996f396596a00a91d03349edc183a6663f9079c5::ssb {
    struct SSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSB>(arg0, 6, b"SSB", b"SUI SNIPE BOT", b"SNIPING BOT FOR SUI, TRACK WALLET, SNIPE BUY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d77f4d64fcd4b19ebbe16bb2c5b64d2fcde21cf11ed662a1e8e6f840f374ba0e_b2c3346fbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

