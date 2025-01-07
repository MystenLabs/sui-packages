module 0xc2120dedb245ac24a902ea6b11cfc583dee9f86ca03aeac3bb2d78187b95abe1::suizi {
    struct SUIZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZI>(arg0, 6, b"SUIZI", b"Suizi The Owl", x"245355495a49206973206d6f7265207468616e2061206d656d65202068652773207468726f75676820746865206e657874206d656d6520636f696e730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000524_a931188955.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

