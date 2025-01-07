module 0x35c334d6851839e1fb9b4e03e252e36d7218d8bb412c5e5a507b5fd4de3c0969::paddy {
    struct PADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PADDY>(arg0, 6, b"Paddy", b"Paddy the platypus", b"Paddy is a Platypus, not a Duck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731689239229.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PADDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PADDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

