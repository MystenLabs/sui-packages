module 0x8228bdafe5b937b2a21a9347928717281775e9ff345f10bfbf9b9c59c7a4631d::hdcity {
    struct HDCITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDCITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDCITY>(arg0, 9, b"HDCITY", b"Jenny ", b"Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0fab88ca-fec7-4735-843b-8ffbadd1cf8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDCITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDCITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

