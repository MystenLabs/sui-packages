module 0xad5c756845ac24575d819f02b554fc4c6b68fd8caa5aab63dcf9cc4195d886c9::top500x {
    struct TOP500X has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOP500X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOP500X>(arg0, 6, b"TOP500X", b"TERMINAL OF PROFITS 500X", b"TOP500X: it only goes up! Trade with max leverage and send it to 500X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5052_f17a2f8643.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOP500X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOP500X>>(v1);
    }

    // decompiled from Move bytecode v6
}

