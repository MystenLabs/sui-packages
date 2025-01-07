module 0x4c6e450f6f21253f42bc2daa6fc10600f85e6e1d88116fe8c4ed786d2b54c77e::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"Doggy on Sui", b"just a doggy on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doggy_f186072fd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

