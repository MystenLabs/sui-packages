module 0x3737a3d3d7de7db318d1ae03e5344df9429dc184b0e0dfd0e962d18da4b61d2d::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 9, b"POPPY", b"Puppy", b"Cute long ear puppy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70b642d5-f5fb-4178-9ace-a78cdbbec2b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

