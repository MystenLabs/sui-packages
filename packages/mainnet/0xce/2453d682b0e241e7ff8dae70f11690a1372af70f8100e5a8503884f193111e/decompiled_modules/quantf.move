module 0xce2453d682b0e241e7ff8dae70f11690a1372af70f8100e5a8503884f193111e::quantf {
    struct QUANTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTF>(arg0, 6, b"QUANTF", b"QUANT FUCK on SUI", b"A 13-year-old created the $QUANT meme coin on Solana, rug-pulled it for $30K, but missed out on $4M as the community pumped it to $80M!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc3_Qy1wa_AAIV_Sm_J_27eef60e00.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

