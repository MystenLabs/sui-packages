module 0xaa575b4194909b6993ad7428ee1426c6b0271d999780b01a8d495f1512fb7e3a::aoi {
    struct AOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOI>(arg0, 9, b"AOI", b"Ank", b"Lamf vui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a841078-2b01-4c56-8f1e-2e0fee0993c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

