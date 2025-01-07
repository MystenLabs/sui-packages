module 0x9238d970682193664d8698b19f2d4ada7d9b4abcdf3eb3223214136a013adb86::gj {
    struct GJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GJ>(arg0, 9, b"GJ", b"MG", b"GFJN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23c8db63-9334-4359-8e54-979d24a60f55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

