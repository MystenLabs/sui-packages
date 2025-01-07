module 0x5e8014dd3ee53d62cf3e42944bf956e8602ac923d25104910d891261995de985::roger {
    struct ROGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGER>(arg0, 6, b"ROGER", b"SUI ROGER", b"Our main objective is to create a path of least resistance for everyone in the crypto space and overtake the corrupt centralized banking system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731598794969.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

