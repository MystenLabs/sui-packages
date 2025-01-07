module 0x47a70317d0e15abbecef726094d22d5feac2e6211eb27c4466bafcb412bd1eb0::om {
    struct OM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OM>(arg0, 6, b"OM", b"OM coin SUI", x"244f4d206a7573742061206c696c20677265656e20616c69656e0a0a68747470733a2f2f782e636f6d2f4f6d436f696e580a68747470733a2f2f742e6d652f6f6d636f696e74670a68747470733a2f2f6f6d636f696e2e6e65742f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_034418_280_b67e30d6aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OM>>(v1);
    }

    // decompiled from Move bytecode v6
}

