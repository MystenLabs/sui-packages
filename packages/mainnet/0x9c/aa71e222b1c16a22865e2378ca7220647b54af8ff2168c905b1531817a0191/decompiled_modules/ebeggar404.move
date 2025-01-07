module 0x9caa71e222b1c16a22865e2378ca7220647b54af8ff2168c905b1531817a0191::ebeggar404 {
    struct EBEGGAR404 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBEGGAR404, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBEGGAR404>(arg0, 6, b"EBeggar404", b"e-beggar 404", b"e-beggar star on Starknet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_c2619a8955.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBEGGAR404>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBEGGAR404>>(v1);
    }

    // decompiled from Move bytecode v6
}

