module 0xe89cbb1245e0f6b7c09a08a7e02a4f09af90d903a10b27a2772f78717176610e::wj {
    struct WJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WJ>(arg0, 9, b"WJ", b"Asking ", x"53682074204920646f6ee2809974206b6e6f7720686f7720746f20646f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1afe668d-747c-4095-91da-db4489fc242a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

