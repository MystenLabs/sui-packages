module 0x9134a7843f123fef29e5d50fa4436614f8edff0e6036ca99d8e6632657b4d26c::pbr {
    struct PBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBR>(arg0, 9, b"PBR", b"Porelessbr", b"Uniquely created indivisible poreless bress", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/750ba0b2-54aa-422a-be37-5e058d05725d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

