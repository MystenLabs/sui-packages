module 0x5f4b31e815fb25b3f9016e53a2ef30142fe3f48972705dcd42c165507d7c53dc::lock {
    struct LOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCK>(arg0, 6, b"LOCK", b"Lock", b"Lock  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_12_24_110239_e6051babc6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

