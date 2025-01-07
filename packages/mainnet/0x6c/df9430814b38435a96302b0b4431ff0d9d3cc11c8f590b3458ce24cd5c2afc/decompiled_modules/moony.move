module 0x6cdf9430814b38435a96302b0b4431ff0d9d3cc11c8f590b3458ce24cd5c2afc::moony {
    struct MOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONY>(arg0, 6, b"MOONY", b"Moony Meme", b"Open a portal to the moonlit world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logos_f0b65097bc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

