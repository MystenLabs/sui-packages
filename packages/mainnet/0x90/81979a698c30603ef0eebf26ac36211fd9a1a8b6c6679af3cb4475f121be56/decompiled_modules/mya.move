module 0x9081979a698c30603ef0eebf26ac36211fd9a1a8b6c6679af3cb4475f121be56::mya {
    struct MYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYA>(arg0, 6, b"MYA", b"Make Your Agent", b"Make your on chain AI agent with just a single click!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_N_Gv1_RHF_400x400_b38031a703.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

