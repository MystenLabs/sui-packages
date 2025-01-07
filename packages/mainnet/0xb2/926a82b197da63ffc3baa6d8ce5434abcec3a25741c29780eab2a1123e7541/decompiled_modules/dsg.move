module 0xb2926a82b197da63ffc3baa6d8ce5434abcec3a25741c29780eab2a1123e7541::dsg {
    struct DSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSG>(arg0, 9, b"DSG", b"FSG", b"GDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c346453f-bfa3-493f-8ee5-98d20beb73fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

