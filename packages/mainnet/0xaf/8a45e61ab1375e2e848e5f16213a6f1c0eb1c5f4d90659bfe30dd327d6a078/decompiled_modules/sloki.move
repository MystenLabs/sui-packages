module 0xaf8a45e61ab1375e2e848e5f16213a6f1c0eb1c5f4d90659bfe30dd327d6a078::sloki {
    struct SLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOKI>(arg0, 6, b"SLOKI", b"SuiFloki", b"Floki is a popular meme-coin embraced by the community. Its time for Floki to dominate the SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sloki_Logo_d52b9bef20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

