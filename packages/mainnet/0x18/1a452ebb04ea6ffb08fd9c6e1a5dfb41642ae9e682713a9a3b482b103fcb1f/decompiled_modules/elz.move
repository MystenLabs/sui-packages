module 0x181a452ebb04ea6ffb08fd9c6e1a5dfb41642ae9e682713a9a3b482b103fcb1f::elz {
    struct ELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELZ>(arg0, 9, b"ELZ", b"Elec House", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ec4da4b-c941-431d-8fed-57a811e74d39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

