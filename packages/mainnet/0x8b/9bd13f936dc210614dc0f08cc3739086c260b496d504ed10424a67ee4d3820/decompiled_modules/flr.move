module 0x8b9bd13f936dc210614dc0f08cc3739086c260b496d504ed10424a67ee4d3820::flr {
    struct FLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLR>(arg0, 9, b"FLR", b"FLOWER", b"Grow your portfolio with this vibrant memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ceb3a04d-a9d2-492c-832c-fc3b16e4badf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

