module 0x18082a938f6f08d9bf9083ddb909c8d25904b87903ff1492d444f335c9986827::pbr {
    struct PBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBR>(arg0, 9, b"PBR", b"Porelessbr", b"Uniquely created indivisible poreless bress", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e9e138e-d719-4d11-b074-cca238bea699.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

