module 0x3fbfb4594ec1579bdd8ea7e2b5f2998cb0bcc6b9bf2b0f6afd7c1367135237c0::pnz {
    struct PNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNZ>(arg0, 6, b"PNZ", b"PONZI", b"A memorial to the great fraudster Charles Ponzi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_U_U_U_U_U_U_U_U_U_U_U_U_U_U_Instagram_4d6f3ef65c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

