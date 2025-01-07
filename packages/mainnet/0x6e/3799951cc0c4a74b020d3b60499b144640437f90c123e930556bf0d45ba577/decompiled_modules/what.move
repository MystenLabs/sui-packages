module 0x6e3799951cc0c4a74b020d3b60499b144640437f90c123e930556bf0d45ba577::what {
    struct WHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHAT>(arg0, 6, b"What", b"What?", b"Wait what?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/premium_photo_1678048604398_f42dda6997bd_e5285d9b0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

