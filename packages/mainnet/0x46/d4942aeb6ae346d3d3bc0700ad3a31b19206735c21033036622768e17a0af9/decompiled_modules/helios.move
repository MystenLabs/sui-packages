module 0x46d4942aeb6ae346d3d3bc0700ad3a31b19206735c21033036622768e17a0af9::helios {
    struct HELIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELIOS>(arg0, 6, b"HELIOS", b"HeliosAI by SuiAI", b"HeliosAI is a carnot engine fueling the AI economy from data to users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2228_320459e084.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELIOS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELIOS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

