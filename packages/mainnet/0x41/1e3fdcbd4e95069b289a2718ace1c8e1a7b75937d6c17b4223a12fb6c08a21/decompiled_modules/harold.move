module 0x411e3fdcbd4e95069b289a2718ace1c8e1a7b75937d6c17b4223a12fb6c08a21::harold {
    struct HAROLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAROLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAROLD>(arg0, 6, b"HAROLD", b"Harold Sui", b"$HAROLD and adventuros hermit crab discovered a shimering Shell at the bottom of the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_054829_912bd4f511.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAROLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAROLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

