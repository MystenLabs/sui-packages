module 0x3a07c63892a58d7d94a0bdc4169fa1ded8e7665ca01cf3ef31c6564b76245f4e::emoji {
    struct EMOJI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EMOJI>, arg1: 0x2::coin::Coin<EMOJI>) {
        0x2::coin::burn<EMOJI>(arg0, arg1);
    }

    fun init(arg0: EMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOJI>(arg0, 2, b"SUIDOGE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMOJI>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<EMOJI>(&mut v2, 10000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOJI>>(v2, v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EMOJI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EMOJI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

