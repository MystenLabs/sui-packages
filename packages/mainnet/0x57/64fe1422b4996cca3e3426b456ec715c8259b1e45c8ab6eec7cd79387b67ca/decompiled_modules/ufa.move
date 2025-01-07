module 0x5764fe1422b4996cca3e3426b456ec715c8259b1e45c8ab6eec7cd79387b67ca::ufa {
    struct UFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFA>(arg0, 6, b"UFA", b"UFARDIO", b"Welcome to UFARDIO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958033408.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UFA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

