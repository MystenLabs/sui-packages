module 0x281387de0f0f38ee6d8b6558548ef5123f133581ca501bcb856fb46f3dc1bdb7::washmyass {
    struct WASHMYASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASHMYASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASHMYASS>(arg0, 6, b"WASHMYASS", b"WASH MY ASS", b"Please daddy wash my ass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000169524_77c965cdd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASHMYASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASHMYASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

