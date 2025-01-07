module 0xa5aa20d12204e9b1477155c7457fc08a783fc2224bd18bb7c4da774426b55ffe::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 9, b"SLOTH", b"Slothana", b"Slothana coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/107cfac4-25c1-4aba-ad9a-88f291c976a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

