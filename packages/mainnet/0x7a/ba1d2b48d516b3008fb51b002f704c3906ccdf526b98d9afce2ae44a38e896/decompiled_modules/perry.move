module 0x7aba1d2b48d516b3008fb51b002f704c3906ccdf526b98d9afce2ae44a38e896::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 6, b"PERRY", b"The Sui Agent", b"PERRY who leads a double life as the best $SUI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capa_53_3b43bce216.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

