module 0xcbb5fd008fc0b545d2f59dc4420677506ccad5cb7295f84d0c0bc5b361996bd::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 6, b"CR7", b"CR7 COIN ON SUI", b"GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo3_ed7002c78f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

