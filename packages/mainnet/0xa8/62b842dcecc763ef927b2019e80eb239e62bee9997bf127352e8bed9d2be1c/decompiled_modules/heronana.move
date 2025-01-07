module 0xa862b842dcecc763ef927b2019e80eb239e62bee9997bf127352e8bed9d2be1c::heronana {
    struct HERONANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERONANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERONANA>(arg0, 6, b"HERONANA", b"SuiNana", x"616d20746865207265616c206865726f2120546865206f6e65207472756520736176696f7220666f7220796f7520616c6c21204920616d207468652073757065722064757065722062616e616e6121200a0a464c5920484947482057495448205355504552204455504552205355494e414e41", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_3_86287992e6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERONANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERONANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

