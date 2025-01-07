module 0xc6f662288631b9f7529e83e39d2b4b5d49c54f4c1949315fc1642e74ae9d270d::freedom {
    struct FREEDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEDOM>(arg0, 6, b"Freedom", b"Freedom CZ", b"Welcome to Freedom CZ on the SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727320527435_d1e682766a477281f531ac9526afcfed_610c764088.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEDOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEDOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

