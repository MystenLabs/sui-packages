module 0x2ccc02da7f2838e5ebba14f12da7f88bfc94b1c9b024e8e878291ca98c50ad9b::lmao {
    struct LMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMAO>(arg0, 6, b"Lmao", b"L Mao", b"*** LONG MAO: A SUI meme token blending Pepes charm with a cats elegance, known for its longest neck in crypto! ***", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_30_at_12_05_29a_pm_a72798223d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

