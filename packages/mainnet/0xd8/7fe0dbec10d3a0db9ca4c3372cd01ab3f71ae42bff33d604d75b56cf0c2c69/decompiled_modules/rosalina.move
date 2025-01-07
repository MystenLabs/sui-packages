module 0xd87fe0dbec10d3a0db9ca4c3372cd01ab3f71ae42bff33d604d75b56cf0c2c69::rosalina {
    struct ROSALINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSALINA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROSALINA>(arg0, 6, b"ROSALINA", b"Rosalina - The First RWA AI Agent on SUI by SuiAI", b"Rosalina stands as a pioneering AI within the SUI blockchain ecosystem, specifically designed to facilitate the integration and management of Real World Assets (RWAs). This AI embodies the innovative spirit of bridging traditional assets with the digital realm through blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_2_b2d676fe9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROSALINA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSALINA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

