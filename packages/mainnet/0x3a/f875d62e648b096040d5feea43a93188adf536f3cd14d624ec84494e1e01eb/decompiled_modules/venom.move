module 0x3af875d62e648b096040d5feea43a93188adf536f3cd14d624ec84494e1e01eb::venom {
    struct VENOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENOM>(arg0, 6, b"VENOM", b"VenuMusk", b"Venom came to Earth to find a man who could transport his fellow tribesmen from their dying home planet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735091283044.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VENOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

