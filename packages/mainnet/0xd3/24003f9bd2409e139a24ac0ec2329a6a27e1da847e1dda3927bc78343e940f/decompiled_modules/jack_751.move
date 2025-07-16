module 0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751 {
    struct JACK_751 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK_751, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK_751>(arg0, 6, b"Jack-751", b"Jack-751_COIN", b"Jack-751_COIN_Description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JACK_751>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK_751>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JACK_751>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JACK_751>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

