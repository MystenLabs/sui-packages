module 0x794f9e76ab6bebf87bfdbc0be26f20d8b6610b3ee9ae3d495ff10c8e73df60f9::jake {
    struct JAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAKE>(arg0, 6, b"JAKE", b"Sui Jake", b"I'm here to make waves hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_06_21_T190648_104_5ba994953b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

