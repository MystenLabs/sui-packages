module 0x84e7bbb81edb765984bfcfc412cf17df01faf421a6ad7020abf55f6ee1202dc9::potion {
    struct POTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTION>(arg0, 6, b"POTION", b"Sui Potion", b"Brewed to perfection, $POTION brings magic and mystery to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_25_d19ea94e6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

