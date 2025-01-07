module 0x3a12190096c5ab0763eeacffb389f2b7eb4b970c532bde1119bfd2d6b469ea81::octos {
    struct OCTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOS>(arg0, 6, b"OCTOS", b"OCTOPUSUI", b"ONLY REAL $OCTOS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/06f183022596fbab94d67c51c0432a33b9e38412_990b4afb0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

