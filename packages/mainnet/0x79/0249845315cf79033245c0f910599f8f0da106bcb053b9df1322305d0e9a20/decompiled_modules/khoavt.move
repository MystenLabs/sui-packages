module 0x790249845315cf79033245c0f910599f8f0da106bcb053b9df1322305d0e9a20::khoavt {
    struct KHOAVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHOAVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHOAVT>(arg0, 9, b"KHOAVT", b"Viettiep", b"Khoa Viet Tiep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6661f1a-90c9-4787-9de5-903be5d104dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHOAVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHOAVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

