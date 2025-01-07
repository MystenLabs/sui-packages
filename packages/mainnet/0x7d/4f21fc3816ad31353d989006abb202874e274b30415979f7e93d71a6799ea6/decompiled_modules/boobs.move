module 0x7d4f21fc3816ad31353d989006abb202874e274b30415979f7e93d71a6799ea6::boobs {
    struct BOOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBS>(arg0, 6, b"BOOBS", b"BoobsCoin", b"The best Boobs on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Boobcoin_cc6d2721d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

