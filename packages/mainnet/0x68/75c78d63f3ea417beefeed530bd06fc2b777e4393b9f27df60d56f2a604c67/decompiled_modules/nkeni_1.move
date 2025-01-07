module 0x6875c78d63f3ea417beefeed530bd06fc2b777e4393b9f27df60d56f2a604c67::nkeni_1 {
    struct NKENI_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKENI_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKENI_1>(arg0, 9, b"NKENI_1", b"Phil ", b"Creating wealth for my love ones.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28cc08dd-2b9c-4659-b08e-cca6aa0053e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKENI_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKENI_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

