module 0xe74d96383346643fdd70a39791a124da543d17a034c926ca6eab9dc9c53fbb17::fop {
    struct FOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOP>(arg0, 6, b"FOP", b"FISH HIPPO", b"\"Trade it, grade it, lets Fish Hippo raid it!\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_8f033801_b9f9_4a6b_a982_9550de967193_ac1c7658ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

