module 0x2a90398d315ab871a0ebfa610d3d8b2a45236c2f7bbe9191276556572079086a::dhrtlmrt {
    struct DHRTLMRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHRTLMRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHRTLMRT>(arg0, 6, b"DHRTLMRT", b"DHRTLMRT", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHRTLMRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DHRTLMRT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

