module 0x4206a672e2f4a9b971bb07e0e3a989c0194532bc20c9e17a7f71e316b72f32f9::different_ {
    struct DIFFERENT_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIFFERENT_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIFFERENT_>(arg0, 9, b"DIFFERENT_", b"ECCENTRIC", b"SIMPLY DIFFERENT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e43ade82-6eab-4748-9e78-274c89421093.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIFFERENT_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIFFERENT_>>(v1);
    }

    // decompiled from Move bytecode v6
}

