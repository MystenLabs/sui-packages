module 0xc604f860731f6fcac200996bcb2499b2be689c090c63c9597580cec539e5069e::dogwifwig {
    struct DOGWIFWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFWIG>(arg0, 6, b"DogWifwig", b"Dog with a wig", b"First dog with a wig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thmb_b63db14d65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFWIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

