module 0x662fc1f53ba66d94a52dc44c8789c8e3b089e26cce741c863b1e435411b21e00::frtdog {
    struct FRTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRTDOG>(arg0, 9, b"FRTDOG", b"Walter The Farting Dog", b"Walter the farting dog : the ultimate $FARTCOIN challenger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/vjTJVR4ZWpnVFYAdFAmQT1yQmVvWdkSoAikTRkvNhat.png?size=xl&key=da250d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRTDOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRTDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRTDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

