module 0xad05bb0f4126a9a3b54437b3fd16fb9f07c785de30afc33c9c1a1de363865928::patbull {
    struct PATBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATBULL>(arg0, 6, b"PATBULL", b"PATIENCE BULL", b"Patience still thinking whether to come or not....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Patience_the_Bull_93075cdeed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

