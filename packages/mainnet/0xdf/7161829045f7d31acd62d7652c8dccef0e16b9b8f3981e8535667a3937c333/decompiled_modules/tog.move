module 0xdf7161829045f7d31acd62d7652c8dccef0e16b9b8f3981e8535667a3937c333::tog {
    struct TOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOG>(arg0, 6, b"TOG", b"Turtle Dog", b"Is it a turtle? Or is it a dog? No ser that's a $TOG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_23_073229_02c46df710.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

