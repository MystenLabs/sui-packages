module 0x6f154dc68b798c01ffa8066b3960c59e0105769818595f2b7f382ed82d264934::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAXI>(arg0, 6, b"TAXI", b"ROBOTAXI", b"A SUI-CHAIN BASED BLOCKCHAIN PROJECT CREATED TO HONOR ELON MUSK'S AMBITIOUS VISION OF A FULLY AUTONOMOUS FUTURE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038588_b16e52565e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

