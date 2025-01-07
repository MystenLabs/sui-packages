module 0xe1c7dd4c3f22bb3e95e192ce885fd404c5b3a2b8382dbdc49ae5fd8e2ea53750::blowpepe {
    struct BLOWPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOWPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOWPEPE>(arg0, 6, b"BLOWPEPE", b"BLOWPEPE FISH", b"The degen fish of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_4eeee_8a609c6fa4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOWPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOWPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

