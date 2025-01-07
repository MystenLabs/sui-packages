module 0xa074316001cbc2c236cd55e895c6cfef16b259ed1ace3c4f97bf4d2e99a7158c::pusse {
    struct PUSSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSE>(arg0, 6, b"PUSSE", b"Pusse Platypus Sui", b"Pusse is a Platypus, not a Duck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/16446o_s_400x400_f27665588a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

