module 0xb28696b1ee2c06d556d1de4b150e3b4f37cc6af80065f5d2d6ce9f1666342408::hopiumhopi {
    struct HOPIUMHOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPIUMHOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPIUMHOPI>(arg0, 6, b"HOPIUMHOPI", b"HOPIum", b"The hilariously clueless hippo who always gets into ridiculous jungle mishaps! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_223414128_bb3cf70d75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPIUMHOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPIUMHOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

