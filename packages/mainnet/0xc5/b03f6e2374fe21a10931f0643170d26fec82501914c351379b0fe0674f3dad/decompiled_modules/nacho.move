module 0xc5b03f6e2374fe21a10931f0643170d26fec82501914c351379b0fe0674f3dad::nacho {
    struct NACHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NACHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NACHO>(arg0, 6, b"NACHO", b"NACHO on SUI", b"MEET NACHO THE NACHEST ON SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ok_6b3ece5ca3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NACHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NACHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

