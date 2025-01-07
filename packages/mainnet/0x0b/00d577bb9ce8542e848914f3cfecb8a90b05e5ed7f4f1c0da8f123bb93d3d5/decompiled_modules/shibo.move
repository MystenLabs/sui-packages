module 0xb00d577bb9ce8542e848914f3cfecb8a90b05e5ed7f4f1c0da8f123bb93d3d5::shibo {
    struct SHIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBO>(arg0, 6, b"SHIBO", b"My Shibo", b"The First Cutest DOG On Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086268_bc09c9b0b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

