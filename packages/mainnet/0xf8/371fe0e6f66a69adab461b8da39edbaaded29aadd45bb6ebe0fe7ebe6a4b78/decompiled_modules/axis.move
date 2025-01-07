module 0xf8371fe0e6f66a69adab461b8da39edbaaded29aadd45bb6ebe0fe7ebe6a4b78::axis {
    struct AXIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXIS>(arg0, 9, b"AXIS", b"Axis", b"Axis is a general purpose coin meant for the masses. Our goal here at Axis is to expand into various large industries, such as video games and online shopping to make Axis usable for all of your online activities. With your support, we can achieve our goals and make Axis better for all. Meet tomorrow. Meet Axis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://th.bing.com/th/id/OIG2.xSWlRt8klMuMIyqK8Uiw?w=1024&h=1024&rs=1&pid=ImgDetMain")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AXIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

