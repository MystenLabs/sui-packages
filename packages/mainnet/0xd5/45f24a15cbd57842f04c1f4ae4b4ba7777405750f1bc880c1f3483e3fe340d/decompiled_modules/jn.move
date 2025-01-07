module 0xd545f24a15cbd57842f04c1f4ae4b4ba7777405750f1bc880c1f3483e3fe340d::jn {
    struct JN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JN>(arg0, 9, b"JN", b"FBD", b"VS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/605d315d-dd9e-4555-a65b-8460363284e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JN>>(v1);
    }

    // decompiled from Move bytecode v6
}

