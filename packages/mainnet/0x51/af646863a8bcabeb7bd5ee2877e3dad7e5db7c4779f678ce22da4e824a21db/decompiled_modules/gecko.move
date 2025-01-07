module 0x51af646863a8bcabeb7bd5ee2877e3dad7e5db7c4779f678ce22da4e824a21db::gecko {
    struct GECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKO>(arg0, 6, b"Gecko", b"geckosonsui", b"the official token of the @geckosonsol ecosystem | powered by @watchman| ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gecko_f94e814594.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

