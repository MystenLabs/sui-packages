module 0x174ae099f716e2e8d34ab973cf416581472a11593de894fb625ab9fd89c6a4e0::trogunt67 {
    struct TROGUNT67 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROGUNT67, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROGUNT67>(arg0, 9, b"TROGUNT67", b"Bastic", b"Good lusk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a20d5f88-37dd-447b-9197-5aa1d1c39508.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROGUNT67>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROGUNT67>>(v1);
    }

    // decompiled from Move bytecode v6
}

