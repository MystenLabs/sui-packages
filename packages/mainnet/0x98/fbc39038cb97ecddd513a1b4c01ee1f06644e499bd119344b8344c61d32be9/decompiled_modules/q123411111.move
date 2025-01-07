module 0x98fbc39038cb97ecddd513a1b4c01ee1f06644e499bd119344b8344c61d32be9::q123411111 {
    struct Q123411111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q123411111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q123411111>(arg0, 9, b"Q123411111", b"AAA", b"H-andsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d11915af-c7f5-40e2-a62c-68d0f91f23a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q123411111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q123411111>>(v1);
    }

    // decompiled from Move bytecode v6
}

