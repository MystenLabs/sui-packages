module 0x473a9e44621dcc44b439cdac06e315cf58e273170fd2ea7f9252bd218a11f68e::zoo {
    struct ZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOO>(arg0, 6, b"ZOO", b"AI Zoo on SUI", b"AI Zoo - AI generated NFT games on Solana & SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FAGWW_5fe_400x400_74f4c1a3fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

