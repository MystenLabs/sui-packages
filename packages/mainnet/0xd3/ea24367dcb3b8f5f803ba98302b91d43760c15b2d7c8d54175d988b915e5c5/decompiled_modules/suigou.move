module 0xd3ea24367dcb3b8f5f803ba98302b91d43760c15b2d7c8d54175d988b915e5c5::suigou {
    struct SUIGOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOU>(arg0, 6, b"SUIGOU", b"suigou", x"530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000153_8389864287.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

