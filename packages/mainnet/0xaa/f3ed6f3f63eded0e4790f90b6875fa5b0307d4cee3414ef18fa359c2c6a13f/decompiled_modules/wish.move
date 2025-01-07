module 0xaaf3ed6f3f63eded0e4790f90b6875fa5b0307d4cee3414ef18fa359c2c6a13f::wish {
    struct WISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISH>(arg0, 6, b"WiSH", b"CatButt", b"Humanity's always had a special connection with the cat...butt why(?)...? Ever notice how a feline behind will subtly find its way in your face(?) Scoff not(!) The mystical being is simply offering you an opportunity to make a wish upon its star( ! )", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731387845055.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

