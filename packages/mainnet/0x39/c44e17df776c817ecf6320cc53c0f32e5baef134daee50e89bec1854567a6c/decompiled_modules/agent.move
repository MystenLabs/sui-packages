module 0x39c44e17df776c817ecf6320cc53c0f32e5baef134daee50e89bec1854567a6c::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"Sui Agent", b"Sui Agent Is a community-Driven project on sui network with community support and massive hype Sui agent will be going to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241212_170644_36_447060ad51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

