module 0x6afea3de112c8a935c4986e4546a622e9813fac46995bf8fb0b6f2d35ebed4c0::pbr {
    struct PBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBR>(arg0, 9, b"PBR", b"Porelessbr", b"Uniquely created indivisible poreless bress", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aeb8cf82-b9ce-4a49-b560-6cf4d9084755.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

