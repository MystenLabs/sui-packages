module 0x411ad2e39afbad0f05cf71cac20e2a362df20e15c059c5a08f16f9a9dca38fe::khoavt {
    struct KHOAVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHOAVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHOAVT>(arg0, 9, b"KHOAVT", b"Viettiep", b"Khoa Viet Tiep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa47adab-83a6-459c-b62d-79f701683110.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHOAVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHOAVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

