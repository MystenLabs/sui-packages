module 0x8fb1867ecbe887eb9210695110c63403a7ad5304d6e9b6f902b118bf004e2922::somo {
    struct SOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMO>(arg0, 9, b"SOMO", b"Somo", b"A memecoin of KA updates community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/471cff5d-689b-4988-bc8d-aaae77d79127.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

