module 0xc3068d7c48c1fa911c3073d177b23076e3776297c2b886138433d78631044a4a::luca {
    struct LUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCA>(arg0, 9, b"LUCA", b"Lucky Cat", b"Lucky from Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a57cf6f5-852a-46f7-adcd-fc8a61326c8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

