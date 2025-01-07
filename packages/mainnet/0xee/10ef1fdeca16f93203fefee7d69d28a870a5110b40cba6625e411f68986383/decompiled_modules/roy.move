module 0xee10ef1fdeca16f93203fefee7d69d28a870a5110b40cba6625e411f68986383::roy {
    struct ROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROY>(arg0, 9, b"ROY", b"Hate Roy", b"Ah ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18a2687d-1b61-4f2e-9cca-57e6f80601ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROY>>(v1);
    }

    // decompiled from Move bytecode v6
}

