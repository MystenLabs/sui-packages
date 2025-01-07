module 0xb92666f5d541c427f5e59bc30b806e688a10573e069a36b537e5e5deef65ce80::catbalt {
    struct CATBALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBALT>(arg0, 6, b"CATBALT", b"SUI CAT BALT", b"And let's not forget, Balt holds a special place in Brett's heart - the absolute darling of the Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/balt_t_dcbbed5c73.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

