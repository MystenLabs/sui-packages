module 0x7d35e974b80bcd424e2edaff912b2255ada36465fe89db206663d4adfb85e6af::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKT>(arg0, 9, b"REKT", b"REK", b"RE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2db4c309-f8c3-44a1-96ac-f3dc017f4f59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

