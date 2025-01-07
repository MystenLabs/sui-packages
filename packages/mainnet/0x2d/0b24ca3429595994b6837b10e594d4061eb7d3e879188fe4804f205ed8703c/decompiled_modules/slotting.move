module 0x2d0b24ca3429595994b6837b10e594d4061eb7d3e879188fe4804f205ed8703c::slotting {
    struct SLOTTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTTING>(arg0, 9, b"SLOTTING", b"SLOT", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bba8553-5796-451f-9d9c-ecd2a450e1c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOTTING>>(v1);
    }

    // decompiled from Move bytecode v6
}

