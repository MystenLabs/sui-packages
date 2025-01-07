module 0x2f3a1fdfb95e0db56643378232f53389e50497f4316c18ff098b32059946749b::dopi {
    struct DOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPI>(arg0, 6, b"DOPI", b"Dopi The Dolphin", b"Dopi is designed to create opportunities within the blockchain ecosystem. Our mission is to build a dynamic community where every member can interact, contribute, and grow together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241031_051805_aef254abc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

