module 0x11cddf38f13ab5346462b6a0fda05121325d3f129e8e806effbda1904c9b7f3e::cduck {
    struct CDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDUCK>(arg0, 6, b"Cduck", b"Catduck", b"cat duck on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5a28638dc9bc72db4b13b2ec7d17b313_075c3be645.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

