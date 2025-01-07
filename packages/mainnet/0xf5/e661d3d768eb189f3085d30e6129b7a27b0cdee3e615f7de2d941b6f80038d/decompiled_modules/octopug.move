module 0xf5e661d3d768eb189f3085d30e6129b7a27b0cdee3e615f7de2d941b6f80038d::octopug {
    struct OCTOPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUG>(arg0, 6, b"OCTOPUG", b"Octopug", b"Definitely an octopus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71di_nup_Ah_L_6ce81f27de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

