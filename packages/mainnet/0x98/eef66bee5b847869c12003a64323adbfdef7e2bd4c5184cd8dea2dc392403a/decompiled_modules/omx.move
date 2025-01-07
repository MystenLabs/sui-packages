module 0x98eef66bee5b847869c12003a64323adbfdef7e2bd4c5184cd8dea2dc392403a::omx {
    struct OMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMX>(arg0, 9, b"OMX", b"Ommix ", b"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d02ef3d1-473f-4633-814f-7aadefccb3b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

