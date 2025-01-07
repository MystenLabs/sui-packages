module 0x545bb07bdc32daf6e94ab8767533a7d3d434b7ba1dfd84164389dd94b58bc683::phamhiep {
    struct PHAMHIEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAMHIEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHAMHIEP>(arg0, 9, b"PHAMHIEP", b"Momo ", b"Im momo tokens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fda6bcd6-205e-4a6e-9b48-16a86ef02ba5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHAMHIEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHAMHIEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

