module 0x8a5cbce60cf4000f040919f830c8a50993ca5f73758128c2408638b1cd1b394::gingcat {
    struct GINGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINGCAT>(arg0, 6, b"GingCat", b"Ginger Cat", b"Everybody needs a ginger cat at Christmas time.  Keep smiling with your ginger cat. Feel like you have one now with the Ginger Cat Coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gingercat_b3cd83aed4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

