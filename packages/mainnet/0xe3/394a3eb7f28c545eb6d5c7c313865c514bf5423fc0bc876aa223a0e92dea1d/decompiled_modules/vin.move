module 0xe3394a3eb7f28c545eb6d5c7c313865c514bf5423fc0bc876aa223a0e92dea1d::vin {
    struct VIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIN>(arg0, 9, b"VIN", b"Vinti", b"Sui is always the best ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36a5732c-3508-4363-90f1-94c82b907d4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

