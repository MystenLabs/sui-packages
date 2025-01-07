module 0xc2c991f81b28a130dd06540d0849a66814e0645bdd43f34ea10eabd62f60d64a::dogmas {
    struct DOGMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMAS>(arg0, 6, b"Dogmas", b"Christmas Dog", b"DOGMAS under cozy, twinkling lights, a puppy in a Santa hat softly grooves to the sound of hidden treats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogmas_c54e7f6f6a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

