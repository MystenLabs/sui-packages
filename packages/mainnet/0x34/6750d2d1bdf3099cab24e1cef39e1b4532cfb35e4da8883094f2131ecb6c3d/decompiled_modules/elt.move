module 0x346750d2d1bdf3099cab24e1cef39e1b4532cfb35e4da8883094f2131ecb6c3d::elt {
    struct ELT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELT>(arg0, 9, b"ELT", b"EL TRUMP", x"454c5420544f20544845204d4f4f4ef09f94a5f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b07af12a-f14b-41a9-8314-9358bdb795f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELT>>(v1);
    }

    // decompiled from Move bytecode v6
}

