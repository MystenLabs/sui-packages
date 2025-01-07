module 0xcec43dd37226807e20fb86577ad98e034064555fcf5175ed3fd29614a7c8e412::eels {
    struct EELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EELS>(arg0, 6, b"Eels", b"Garden eels", b"Garden eels are group life, and we know each other very well, and in the virtual currency market, we need to have a group consensus to own this meme coin together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732381759406.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EELS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EELS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

