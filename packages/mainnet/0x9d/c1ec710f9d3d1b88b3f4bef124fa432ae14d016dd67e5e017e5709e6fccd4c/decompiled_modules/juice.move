module 0x9dc1ec710f9d3d1b88b3f4bef124fa432ae14d016dd67e5e017e5709e6fccd4c::juice {
    struct JUICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUICE>(arg0, 6, b"Juice", b"Juice wrld", b"999 4eva", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6522_d322af2e9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

