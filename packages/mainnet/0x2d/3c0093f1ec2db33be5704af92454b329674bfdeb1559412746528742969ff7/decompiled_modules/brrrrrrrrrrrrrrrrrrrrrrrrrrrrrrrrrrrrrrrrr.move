module 0x2d3c0093f1ec2db33be5704af92454b329674bfdeb1559412746528742969ff7::brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr {
    struct BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR>(arg0, 6, b"Brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr", b"Moneyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy", b"Crypto investors when fed cuts rates 'Money go brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brrrr_3c54ca5338.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

