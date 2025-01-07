module 0x7269e32aaa5d8494ad2f7f7249ce6981ce5683af57395d7f68bd5ddb9b213df2::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"Slice of Pizza", b"Just a slice of Pizza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/slice_of_pizza_e2e5e4291c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

