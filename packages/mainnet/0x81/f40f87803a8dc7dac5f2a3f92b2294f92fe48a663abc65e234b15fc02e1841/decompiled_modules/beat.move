module 0x81f40f87803a8dc7dac5f2a3f92b2294f92fe48a663abc65e234b15fc02e1841::beat {
    struct BEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAT>(arg0, 9, b"BEAT", b"Beat", b"beater", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9039044-3d42-4f84-8d78-2af7c681615b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

