module 0xeb1372485f0586cb6993305782261502a64ae396dd7bfd6f695b4752b6c3e5e2::seaking {
    struct SEAKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAKING>(arg0, 6, b"SEAKING", b"Seaking", b"Seaking is known for its elegant orange-and-white body and powerful horn, it often uses moves like Waterfall, Peck, and Aqua Tail.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/seaking_8e358e38a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

