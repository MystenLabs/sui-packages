module 0x74505b4124ccc9a9dab3422da906f7200383f717b299cacaf348340aea876c1e::crs {
    struct CRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRS>(arg0, 9, b"CRS", b"Criuse", b"Catch criuse for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee4b0182-db45-463e-aaef-32477ef7f632.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

