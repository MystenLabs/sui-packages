module 0x8398d912038c77703602ae2798ab4c6702f2b90d1e8c4102bd12220e1c6dbb3f::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"SUI GOD", b"SUI GOD IS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sos_a3bffad4b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

