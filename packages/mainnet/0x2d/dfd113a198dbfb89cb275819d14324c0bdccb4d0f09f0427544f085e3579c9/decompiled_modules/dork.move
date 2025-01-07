module 0x2ddfd113a198dbfb89cb275819d14324c0bdccb4d0f09f0427544f085e3579c9::dork {
    struct DORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORK>(arg0, 6, b"DORK", b"DORK SUI", b"Dork has arrived to shake up the Sui community, bringing a fresh spirit to the world of memecoins with potential ready to skyrocket, supported by the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969506079.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

