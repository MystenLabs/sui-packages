module 0x57599147d80d3a6cde27e6fbf53176c254e3018e2fe6a1655603faa108c54868::cccat {
    struct CCCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCCAT>(arg0, 6, b"CCCAT", b"CCCAT ON SUI", b"CCCat Coin is the next-generation memecoin inspired by the Internets favorite phenomenon: the adorable, tongue-out blep expression cats make!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019072_a1714790ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

