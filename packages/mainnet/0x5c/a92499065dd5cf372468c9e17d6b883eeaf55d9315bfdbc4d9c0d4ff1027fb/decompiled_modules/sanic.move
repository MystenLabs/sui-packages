module 0x5ca92499065dd5cf372468c9e17d6b883eeaf55d9315bfdbc4d9c0d4ff1027fb::sanic {
    struct SANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANIC>(arg0, 6, b"SANIC", b"Sanic Coin", b"This dude is Fast AF.Don't say we didnt warn you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_LOGO_192x192_1d0ec4af9b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

