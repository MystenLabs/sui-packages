module 0x99b81114e5a89ac8bb491f153056c24df6954a09bb73405748836a74e49f9d1a::skd {
    struct SKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKD>(arg0, 6, b"SKD", b"SUI-KODEN", b"Suikoden is a famous RPG game for PlayStation and now will be famous on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hero_Suikoden_removebg_preview_080480a581.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

