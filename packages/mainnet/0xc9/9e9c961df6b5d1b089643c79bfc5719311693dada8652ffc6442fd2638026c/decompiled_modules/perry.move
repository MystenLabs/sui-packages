module 0xc99e9c961df6b5d1b089643c79bfc5719311693dada8652ffc6442fd2638026c::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 6, b"PERRY", b"Perry The Platipus", x"546865206375746573742c20696e6e6f63656e7420706c61746970757320796f75276c6c20657665722073656520696e205375692e2049206d65616e206a757374206c6f6f6b206174207468617420637574652c20617574697374696320657965732e2057616e6e61206b6e6f772068697320736563726574733f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6089260686896120314_11178a2806_fbbd4ec492.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

