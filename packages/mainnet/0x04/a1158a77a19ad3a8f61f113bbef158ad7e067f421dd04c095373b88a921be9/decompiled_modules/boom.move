module 0x4a1158a77a19ad3a8f61f113bbef158ad7e067f421dd04c095373b88a921be9::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 9, b"BOOM", b"Boomsday", b"Booom or not Booom?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf99ff41-bf91-4ed1-835c-fdeb5f30ee37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

