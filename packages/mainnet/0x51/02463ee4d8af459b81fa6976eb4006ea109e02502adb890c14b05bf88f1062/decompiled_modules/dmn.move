module 0x5102463ee4d8af459b81fa6976eb4006ea109e02502adb890c14b05bf88f1062::dmn {
    struct DMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMN>(arg0, 9, b"DMN", b"Damon", b"LET'S GO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d2bd1ea-5a12-4847-b5d9-7bcb1e920184.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

