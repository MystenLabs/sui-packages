module 0xc6f28d4edd8dc27fc94c7e4082fc4b26b5181376e5d05dd1717ecc0c1f1ff354::mst {
    struct MST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MST>(arg0, 9, b"MST", b"M4Q", b"Hyt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbcb7925-913f-45f6-bafb-274fc0285bbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MST>>(v1);
    }

    // decompiled from Move bytecode v6
}

