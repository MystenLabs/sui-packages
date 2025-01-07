module 0x211f87c4b290e49ce9b6290657afa43a6ea39431c88c9b83e0f19e189ad0931b::seanut {
    struct SEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEANUT>(arg0, 6, b"SEANUT", b"Seanut The Suirrel", b"In memory of Peanut. RIP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sqqqqq_34e817d747.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEANUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEANUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

