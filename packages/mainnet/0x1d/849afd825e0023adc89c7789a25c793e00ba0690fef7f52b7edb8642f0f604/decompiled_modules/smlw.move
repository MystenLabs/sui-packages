module 0x1d849afd825e0023adc89c7789a25c793e00ba0690fef7f52b7edb8642f0f604::smlw {
    struct SMLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMLW>(arg0, 6, b"SMLW", b"Suishmallow", b"The tastiest memecoin on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coolsuieet_c847ca4b5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

