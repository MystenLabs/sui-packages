module 0x3d31e4616c00aca8d2924e13f5e744fb8da3c616da28f316045d9285abaa412e::gdsa {
    struct GDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSA>(arg0, 9, b"GDSA", b"SADF", b"GRF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b66d19ee-9f61-472d-a0ee-cae6a13650cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

