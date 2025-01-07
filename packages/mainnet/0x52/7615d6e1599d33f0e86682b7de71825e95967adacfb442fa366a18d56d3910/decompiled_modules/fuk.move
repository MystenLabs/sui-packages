module 0x527615d6e1599d33f0e86682b7de71825e95967adacfb442fa366a18d56d3910::fuk {
    struct FUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUK>(arg0, 6, b"Fuk", b"Hello kitty", b"Queen bitch kitty ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9399_148dd645c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

