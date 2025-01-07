module 0xd4edb8d1108aebf697677aa5aae743dd139d1abeef51189fc213bef79b71581a::nintendo {
    struct NINTENDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINTENDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINTENDO>(arg0, 6, b"Nintendo", b"NINTENDO", b"for Nintendo fans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000550_2aee45e64c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINTENDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINTENDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

