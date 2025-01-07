module 0x460f7edec659c3deadc4f7bd191b3641073f0ac97fa4f22fb602516892fecc05::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"SUIBULL", b"BULLSUI are dynamic waves of energy, surging forward with fierce intensity, embodying the pulse of innovation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730703778445.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

