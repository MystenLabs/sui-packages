module 0x188d544198b910cd0a352b0f565bc45142dbb32da75ee7c7444a87371c867d7f::vic {
    struct VIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIC>(arg0, 6, b"VIC", b"Conviction", b"Only Chad's shall enter and millions will be made. Do you have conviction? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000009256_8ab91a364a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

