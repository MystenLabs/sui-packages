module 0x85999bb53a00c36b1d8eb864dbac1ea18bdcbcfcbef20c23cd9121ac48dd216c::kas {
    struct KAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAS>(arg0, 6, b"KAS", b"KASKY", b"LETS GO MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1080x360_647dfb1fa2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

