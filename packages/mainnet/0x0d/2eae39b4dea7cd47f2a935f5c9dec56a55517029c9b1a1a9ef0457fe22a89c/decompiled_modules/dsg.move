module 0xd2eae39b4dea7cd47f2a935f5c9dec56a55517029c9b1a1a9ef0457fe22a89c::dsg {
    struct DSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSG>(arg0, 9, b"DSG", b"FSG", b"GDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bebf8a01-bd32-4dd0-87dc-7d348bb2e758.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

