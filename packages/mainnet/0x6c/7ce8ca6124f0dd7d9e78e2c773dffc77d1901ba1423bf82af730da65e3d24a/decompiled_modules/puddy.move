module 0x6c7ce8ca6124f0dd7d9e78e2c773dffc77d1901ba1423bf82af730da65e3d24a::puddy {
    struct PUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDY>(arg0, 6, b"PUDDY", b"YUMMY PUDDY", b"DESSERT IS SERVED, WOBBLE AND GOBBLE $PUDDY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/abba_d79286dd62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

