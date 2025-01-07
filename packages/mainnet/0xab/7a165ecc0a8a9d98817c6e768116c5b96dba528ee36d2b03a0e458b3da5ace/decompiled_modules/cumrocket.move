module 0xab7a165ecc0a8a9d98817c6e768116c5b96dba528ee36d2b03a0e458b3da5ace::cumrocket {
    struct CUMROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUMROCKET>(arg0, 6, b"CUMROCKET", b"Cum Rocket", b"Cum Rocket of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cum_Rocket_2408106b40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUMROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

