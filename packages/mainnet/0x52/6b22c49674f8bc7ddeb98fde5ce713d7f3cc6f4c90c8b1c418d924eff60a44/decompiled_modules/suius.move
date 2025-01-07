module 0x526b22c49674f8bc7ddeb98fde5ce713d7f3cc6f4c90c8b1c418d924eff60a44::suius {
    struct SUIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUS>(arg0, 6, b"SUIUS", b"America", b"In preparation for the election", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_C_8d66b4ee57.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

