module 0x7465c77d22837bd5f142f5ae97bcf292dbf690689b7c2b34cc262b925f71bed3::vui {
    struct VUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUI>(arg0, 9, b"VUI", b"WeWedung28", b"gdr egerg egergr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8210b72d-e8cb-43ac-b3e2-4702ea8c7a37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

