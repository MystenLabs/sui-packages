module 0x160411c70dba60d44dc71f800218ca00c24ea500a3a87a5a3445bb5cdf1331e::mmf {
    struct MMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMF>(arg0, 9, b"MMF", b"memefi", b"MEMEFI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dbfcdf0-e70e-475c-a73e-b729adc5c295.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

