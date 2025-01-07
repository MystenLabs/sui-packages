module 0x887793b8f7accff54ec17ec7957d832f844e26ac62c2f3d657835e95e1936184::ven {
    struct VEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEN>(arg0, 9, b"VEN", b"Venom", b"Pamp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e663429-898f-4cd8-95ab-458aad4563fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

