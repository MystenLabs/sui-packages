module 0xba9e2b588b2a169e7579bc37a20cdc79eace56b57465c3e6d778b17f79b7623a::bic {
    struct BIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIC>(arg0, 9, b"BIC", b"Bia", b"Bi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bb8673a-ca65-4495-8356-222160187325.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

