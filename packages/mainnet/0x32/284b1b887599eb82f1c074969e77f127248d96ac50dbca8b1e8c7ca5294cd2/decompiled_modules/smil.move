module 0x32284b1b887599eb82f1c074969e77f127248d96ac50dbca8b1e8c7ca5294cd2::smil {
    struct SMIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMIL>(arg0, 9, b"SMIL", b"S", b"Smils", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28d3eba5-e0bf-43c9-992f-d57ede7f9c0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

