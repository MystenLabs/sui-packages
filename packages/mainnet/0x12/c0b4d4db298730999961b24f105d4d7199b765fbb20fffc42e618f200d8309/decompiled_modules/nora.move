module 0x12c0b4d4db298730999961b24f105d4d7199b765fbb20fffc42e618f200d8309::nora {
    struct NORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORA>(arg0, 6, b"NORA", b"NORA - Baby Polar Bear", x"5468652063757465737420706f6c6172206265617220696e206578697374656e6365200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kpn4_Hn0_T_400x400_29a89649b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

