module 0xf1f4523c8873be88f4e80c1341ae49a7ffa0f9940ad437e797e5a289ec23d233::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEM>(arg0, 9, b"GEM", b"GEM", b"Real Alpha. Gem token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRC1O0vpOk4yj6UknPt2Ted77suyVnzci6muA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEM>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

