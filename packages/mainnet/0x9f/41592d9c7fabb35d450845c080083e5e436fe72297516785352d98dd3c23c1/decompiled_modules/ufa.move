module 0x9f41592d9c7fabb35d450845c080083e5e436fe72297516785352d98dd3c23c1::ufa {
    struct UFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFA>(arg0, 6, b"UFA", b"UFARDIO", b"Welcome to TURBO UFARDIO https://ufardio.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958771003.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UFA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

