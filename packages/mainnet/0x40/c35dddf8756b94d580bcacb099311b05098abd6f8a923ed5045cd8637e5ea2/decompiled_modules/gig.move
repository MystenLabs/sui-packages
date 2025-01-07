module 0x40c35dddf8756b94d580bcacb099311b05098abd6f8a923ed5045cd8637e5ea2::gig {
    struct GIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIG>(arg0, 6, b"GIG", b"giggity", b"Giggity Giggity Giggity Giggity Giggity Giggity Giggity Giggity Giggity Giggity Giggity Giggity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_1b1eeebd_d9dd4afceb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

