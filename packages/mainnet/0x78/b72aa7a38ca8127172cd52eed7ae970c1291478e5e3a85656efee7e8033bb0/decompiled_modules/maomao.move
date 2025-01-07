module 0x78b72aa7a38ca8127172cd52eed7ae970c1291478e5e3a85656efee7e8033bb0::maomao {
    struct MAOMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOMAO>(arg0, 6, b"MAOMAO", b"MAOCAT on SUI", x"47657420696e206f6e20686973746f72792773206669727374206368696e6120636174205355492e0a4d616f204d616f204d616f204d414f4d414f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W_Jw_Jd_Cct_400x400_7a8234ca5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOMAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

