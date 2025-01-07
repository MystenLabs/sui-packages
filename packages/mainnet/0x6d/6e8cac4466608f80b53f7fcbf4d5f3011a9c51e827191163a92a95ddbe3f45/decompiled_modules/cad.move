module 0x6d6e8cac4466608f80b53f7fcbf4d5f3011a9c51e827191163a92a95ddbe3f45::cad {
    struct CAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAD>(arg0, 6, b"CAD", b"catnuday", b"are you scared?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e7843942507f8ba2087d2a0eb8669170_a2573d0619.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

