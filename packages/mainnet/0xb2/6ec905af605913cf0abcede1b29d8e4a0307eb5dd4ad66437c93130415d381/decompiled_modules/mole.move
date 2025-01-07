module 0xb26ec905af605913cf0abcede1b29d8e4a0307eb5dd4ad66437c93130415d381::mole {
    struct MOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLE>(arg0, 9, b"MOLE", b"Mole The Sloth", b"The TikTok famous sloth takes over Sui becoming the cutest animal on-chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7edoQF9NvwPD3ueGXRYFDnahBPMLCafV45vjyh3EFmVk.png?size=xl&key=b7f067")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOLE>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

