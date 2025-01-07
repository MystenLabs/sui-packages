module 0x4b4cb8aa7064d71a93bae1c544dc4b6d67de0fbd8b2fda9f055ce605d000a6f4::fuckhopp {
    struct FUCKHOPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKHOPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKHOPP>(arg0, 6, b"FUCKHOPP", b"FUCK HOP FUN", b"We are the ones who say FUCKHOPP. It means fuck off.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730980985927.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKHOPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKHOPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

