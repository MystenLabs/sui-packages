module 0xdda328e991b9f6d07a5ebb792ee8caa479cd0bf771bced8c181318178b198693::crs {
    struct CRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRS>(arg0, 9, b"CRS", b"CHRISTUS ", b"Is good to go ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/347e3fe1-60d7-477c-8bde-f8f8d92a0ae4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

