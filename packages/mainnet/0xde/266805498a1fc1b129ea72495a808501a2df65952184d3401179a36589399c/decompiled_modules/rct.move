module 0xde266805498a1fc1b129ea72495a808501a2df65952184d3401179a36589399c::rct {
    struct RCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCT>(arg0, 9, b"RCT", b"Roccat", x"526f6363617420746f20746865206d6f6f6e20f09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2bf6a3a8-60fc-4258-bd38-74234c7afec3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

