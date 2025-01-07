module 0x31ba830861ec2593918fb7359869f06b43f0a78291bd7e662b4212958f27b4da::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"Rachop", b"Rachop Sui", b"rachop is thebest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024102018163441_batcheditor_fotor_batcheditor_fotor_ea151a2736.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

