module 0x62febc8b637abe4b473aa0fee349297971ea1450d9063e93c46d55cfaedf3080::cct {
    struct CCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCT>(arg0, 6, b"CCT", b"Can Cat", b"Caution: Contents may meow if shaken.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1585_49b68854cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

