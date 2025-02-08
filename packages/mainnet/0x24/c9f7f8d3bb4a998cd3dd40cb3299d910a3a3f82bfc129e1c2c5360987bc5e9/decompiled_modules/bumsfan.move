module 0x24c9f7f8d3bb4a998cd3dd40cb3299d910a3a3f82bfc129e1c2c5360987bc5e9::bumsfan {
    struct BUMSFAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMSFAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMSFAN>(arg0, 6, b"BumsFan", b"BumsFanS", b"Official BumsFan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000063_ce9ab03cb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMSFAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMSFAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

