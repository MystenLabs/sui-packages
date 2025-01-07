module 0x5eeea940ebe2e2d75742aed43a55b12a8b5efebee3a605fef369b477f976a805::rtyuj {
    struct RTYUJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTYUJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTYUJ>(arg0, 9, b"RTYUJ", b"hdsfgds", b"dssdfs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f692542-3b90-4fd9-b115-4648eb6a134f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTYUJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTYUJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

