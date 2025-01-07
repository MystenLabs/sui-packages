module 0x21592ac0825560fb86380d8fd34273463a90d2e5675ccb87c9e413139671de72::merrio {
    struct MERRIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERRIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERRIO>(arg0, 6, b"MERRIO", b"Merrio on Sui", b"MERRIO the green gospel of memes while unearthing the juiciest opportunities in the market with Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053408_c6e89c42f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERRIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERRIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

