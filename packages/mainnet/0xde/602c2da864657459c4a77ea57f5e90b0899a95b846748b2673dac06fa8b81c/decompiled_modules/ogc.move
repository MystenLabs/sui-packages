module 0xde602c2da864657459c4a77ea57f5e90b0899a95b846748b2673dac06fa8b81c::ogc {
    struct OGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGC>(arg0, 9, b"OGC", b"Ogc app", b"Ogc meme token. Buy this meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe213419-aa14-4243-ad0e-8c01e40b303c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

