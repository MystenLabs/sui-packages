module 0xb5bc36675bd2071f0994f5823ad5cc6066a741f11f67465cfd4d4ada8fddd2be::elix {
    struct ELIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELIX>(arg0, 6, b"ELIX", b"Elixir", b"Nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733066289248.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

