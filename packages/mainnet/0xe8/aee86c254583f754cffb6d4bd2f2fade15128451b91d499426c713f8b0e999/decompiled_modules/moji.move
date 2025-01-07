module 0xe8aee86c254583f754cffb6d4bd2f2fade15128451b91d499426c713f8b0e999::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 9, b"MOJI", b"Moji", x"244d4f4a49202d20f09f8d86205468652042696720507572706c6520456d6f6a6920205374617274696e672074686520656d6f6a692d6669206d657461206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CB48KiK1oi1tWtjmPWxVR2NPeEr9ewzmZQ8ERk79Ue4b.png?size=xl&key=e3d4b7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOJI>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

