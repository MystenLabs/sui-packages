module 0x4439f68fdbb5a9b4454a43fc077fabc0dfc620c0c37b3c1ec0dde7f438659f53::gwnw {
    struct GWNW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWNW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWNW>(arg0, 9, b"GWNW", b"bden", b"ndnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/053f9713-5205-4db6-b58a-dbc5e7903ef3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWNW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWNW>>(v1);
    }

    // decompiled from Move bytecode v6
}

