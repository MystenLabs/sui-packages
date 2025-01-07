module 0x616ca13bb3369c9215d2db5acd726b17f45bb447b13cc92d7147ec48da8df09a::nope {
    struct NOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOPE>(arg0, 6, b"NOPE", b"NOPE.", x"4973207468657265206120776562736974653f204e4f50450a547769747465723f204e4f50450a414e595448494e473f21204e4f50450a446f207765207265616c6c7920636172653f202e2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NOPE_273be52575.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

