module 0x385460f5dfae46393ce6595948f1caa593ec5c08d12276630a04634991481529::g {
    struct G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G>(arg0, 9, b"G", b"Grass", b"Enjoyment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d3d4c91-83c3-4384-af2b-f848444d1e6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G>>(v1);
    }

    // decompiled from Move bytecode v6
}

