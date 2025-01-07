module 0xe9218c9f5b437b6ef88d541bc6a82d3218b3cd2917b36ddfbe463c556c6cf50d::hanbao {
    struct HANBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBAO>(arg0, 6, b"Hanbao", b"hanbao", b"hello im hanbao i will chill on sui~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c0b86338_d4a0_4e87_99af_b34e722c4bc1_1_ddd453e14e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

