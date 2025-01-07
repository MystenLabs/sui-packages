module 0xf5693ef1c891184e55fbb930788c9f652e49506c9a8a34d7c98a513a783b69f9::crying {
    struct CRYING has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYING>(arg0, 6, b"CRYING", b"Sui Crying", b"cat crying, please adopt me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014933_45a4e20d6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYING>>(v1);
    }

    // decompiled from Move bytecode v6
}

