module 0x9aa08a2d25bf4b9133aceb29eee552357fdb0bda684bf8cde57beb0d728ef5ff::kind {
    struct KIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIND>(arg0, 9, b"KIND", b"Kindly tok", b"This token is created to help the poor. Be kind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf5d16a2-53e3-4948-af38-217fdf67b157.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

