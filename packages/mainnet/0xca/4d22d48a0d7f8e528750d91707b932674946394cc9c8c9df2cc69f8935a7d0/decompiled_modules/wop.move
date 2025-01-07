module 0xca4d22d48a0d7f8e528750d91707b932674946394cc9c8c9df2cc69f8935a7d0::wop {
    struct WOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOP>(arg0, 9, b"WOP", b"Pow", b"Test 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/049e935c-c5ac-4542-b51f-8bb771e735f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

