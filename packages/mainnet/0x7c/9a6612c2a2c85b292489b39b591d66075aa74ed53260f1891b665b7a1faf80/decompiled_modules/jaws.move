module 0x7c9a6612c2a2c85b292489b39b591d66075aa74ed53260f1891b665b7a1faf80::jaws {
    struct JAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWS>(arg0, 6, b"JAWS", b"Jaws The Jeet Killer", b"Just when you thought it was safe to go back in the water... $JAWS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003631_9d5cafa5ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

