module 0xa4dcec4680104d7195ab52b85f910811aefa63eb36f3ffd682e584f36b0f0717::elemelt {
    struct ELEMELT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEMELT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEMELT>(arg0, 6, b"ELEMELT", b"Elephant Melt", b"This is a hashish brand from Canada which I created the art work for and I just took my character and put a SUI tattoo on his ass and presto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elephentmelt_520988b8aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEMELT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEMELT>>(v1);
    }

    // decompiled from Move bytecode v6
}

