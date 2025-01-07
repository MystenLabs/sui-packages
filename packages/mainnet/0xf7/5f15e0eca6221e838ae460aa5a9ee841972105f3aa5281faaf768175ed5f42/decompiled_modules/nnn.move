module 0xf75f15e0eca6221e838ae460aa5a9ee841972105f3aa5281faaf768175ed5f42::nnn {
    struct NNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNN>(arg0, 6, b"NNN", b"No Not November", b"no nut november is going to be really hard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/no_nut_november_cartoon_illustration_premium_cartoon_vector_icon_illustration_food_object_isolated_138676_6549_a4fab3005c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

