module 0x14f87e16a1cffc9521cf3de480693aef115f2b5362bafc568f00a811fb58e158::baybear {
    struct BAYBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAYBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYBEAR>(arg0, 6, b"BAYBEAR", b"Baybear by Matt Furie", b"Meet BayBear, the wealthy bear with a mission to shake things up on the SUI network! Hes not just sitting on his mountain of wealthBayBears all about using his riches to drive innovation and transformation. With a mind as sharp as his claws, hes diving deep into the blockchain world, making moves thatll revolutionize how things work. BayBears got the vision and the resources, and when he steps in, you can bet the whole SUI ecosystem will feel the ripple effect. Change is coming, and BayBears leading the charge!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240714_035541_1_9194502ad7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAYBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

