module 0x37c5380b62173095a80f0f66e159d2d6eb7dc6826866221075c7ed21799f7dd0::prmc {
    struct PRMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRMC>(arg0, 6, b"PRMC", b"PRIME MACHIN", b"Buy to get airdrop NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951467417.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRMC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRMC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

