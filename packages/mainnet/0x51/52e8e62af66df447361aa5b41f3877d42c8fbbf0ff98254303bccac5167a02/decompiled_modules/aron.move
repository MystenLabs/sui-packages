module 0x5152e8e62af66df447361aa5b41f3877d42c8fbbf0ff98254303bccac5167a02::aron {
    struct ARON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARON>(arg0, 6, b"ARON", b"Aron's Vault", b"Aron's Vault is a memecoin inspired by the journey of Aron and Toro Maximus. It represents the quest for financial freedom and the unity of the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735302971111.17")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

