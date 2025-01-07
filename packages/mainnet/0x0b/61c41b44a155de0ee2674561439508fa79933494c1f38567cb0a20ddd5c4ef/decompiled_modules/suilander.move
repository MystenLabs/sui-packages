module 0xb61c41b44a155de0ee2674561439508fa79933494c1f38567cb0a20ddd5c4ef::suilander {
    struct SUILANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANDER>(arg0, 6, b"Suilander", b"Homelander on Sui", b"The ultimate power on Sui. Ruthless, unstoppable, and always in control. Bow down, because Sui Homelander plays by his own rules!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_e888c25179.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

