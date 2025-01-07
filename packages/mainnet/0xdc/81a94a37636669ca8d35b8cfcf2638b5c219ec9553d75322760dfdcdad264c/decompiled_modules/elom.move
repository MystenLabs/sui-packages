module 0xdc81a94a37636669ca8d35b8cfcf2638b5c219ec9553d75322760dfdcdad264c::elom {
    struct ELOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELOM>(arg0, 6, b"Elom", b"Elom Mars", b"Elom Mars is  a meme coin dedicated to Elon Musk's mars mission. They've been looking for the water on mars, but sui waterchain is already there. Elom will be the first mars cryptocurrency ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ykahd3_8736a093cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

