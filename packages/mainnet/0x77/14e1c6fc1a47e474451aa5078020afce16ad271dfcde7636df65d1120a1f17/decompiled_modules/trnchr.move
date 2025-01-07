module 0x7714e1c6fc1a47e474451aa5078020afce16ad271dfcde7636df65d1120a1f17::trnchr {
    struct TRNCHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRNCHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRNCHR>(arg0, 6, b"TRNCHR", b"TRENCHOR", b"I am tired, just want to make a little money in the trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tired_d78a966e0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRNCHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRNCHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

