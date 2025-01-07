module 0x935e53a8a81d6507928413d10fbf43170ff9df7318f2f21b7a74c600b88d43e5::dj {
    struct DJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJ>(arg0, 6, b"DJ", b"DONEJESUS", b"He approves all your karma and relieves you from your sins saying done", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000123846_a51bc694bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

