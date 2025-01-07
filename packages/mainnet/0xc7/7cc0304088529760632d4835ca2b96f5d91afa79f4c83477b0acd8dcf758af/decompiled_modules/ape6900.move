module 0xc77cc0304088529760632d4835ca2b96f5d91afa79f4c83477b0acd8dcf758af::ape6900 {
    struct APE6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE6900>(arg0, 6, b"APE6900", b"APE6900 LABS", b"APE6900 LABS ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6ec1464377a58b55efd9dd3f1a90ba13_4d8ad70786.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APE6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

