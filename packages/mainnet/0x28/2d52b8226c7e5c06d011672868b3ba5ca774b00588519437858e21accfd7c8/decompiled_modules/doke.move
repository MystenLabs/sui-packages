module 0x282d52b8226c7e5c06d011672868b3ba5ca774b00588519437858e21accfd7c8::doke {
    struct DOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKE>(arg0, 6, b"DOKE", b"Doke", b"doke is the best dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Original_Doge_meme_0cae625276.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

