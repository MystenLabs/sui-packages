module 0xc1a6437b0f857443912936b0eaa8aad546b5d256c03675b54f6d301624e92ad::suihero {
    struct SUIHERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHERO>(arg0, 6, b"SuiHero", b"SuiNana", x"4920616d20746865207265616c206865726f2120546865206f6e65207472756520736176696f7220666f7220796f7520616c6c21204920616d207468652073757065722064757065722062616e616e6121200a0a464c5920484947482057495448205355504552204455504552205355494e414e41", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_3_835a350070.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

