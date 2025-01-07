module 0xada3b1f3473e59dd5aecb75b895a05406b37c776a55b78f625e98fa2378c9137::pepsisuiman {
    struct PEPSISUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSISUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSISUIMAN>(arg0, 6, b"PEPSISUIMAN", b"PEPSUIMAN", x"5045505355494d414e204953204845524520210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_171303949_a8198991cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSISUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSISUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

