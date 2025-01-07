module 0x2dd969c7b94b25aef811e58d6fab7dfc91cff1761bc05e30d19361d9857e365f::dbs {
    struct DBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBS>(arg0, 6, b"DBS", b"Dickbutt", b"The glorious & most prestigious 2006 dickbutt meme now on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_12_at_11_37_50a_am_58b39c6705.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

