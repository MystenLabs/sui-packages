module 0xf6763a3e6ac4a84503a4db4f8895cbdc5bffc37b15006105b0292c0b1add9925::tasla {
    struct TASLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TASLA>(arg0, 6, b"TASLA", b"TASK", b"TASLA FOOR VIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AUHV_ULGI_9a69735029.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TASLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

