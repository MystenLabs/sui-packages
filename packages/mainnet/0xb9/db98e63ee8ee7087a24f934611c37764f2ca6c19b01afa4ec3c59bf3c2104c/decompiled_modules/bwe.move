module 0xb9db98e63ee8ee7087a24f934611c37764f2ca6c19b01afa4ec3c59bf3c2104c::bwe {
    struct BWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWE>(arg0, 9, b"BWE", b"Bwewe", b"Dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2aa6bfc-c2ce-4034-bf4f-0366c1ebb958.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

