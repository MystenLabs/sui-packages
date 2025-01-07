module 0xe68fc9ab55e38b80e90e5446a0f1c1712b3de1d097a110f84f195ec2e28a2f77::scream {
    struct SCREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCREAM>(arg0, 6, b"SCREAM", b"SCREAM", b"Don't Answer The Door, Don't Leave The House, Don't Scream!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/3UhxA8jBKYEhJQxG9VzNYFFGkZ5brZtWMuTvbb4rpump.png?size=lg&key=f6466d"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCREAM>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCREAM>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCREAM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

