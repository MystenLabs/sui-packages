module 0x737d62925fa697806ee61bcfec4062400e436bdb27ca2db940c0cc9d4c994a1b::b_undefined {
    struct B_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_UNDEFINED>(arg0, 9, b"bSDA", b"bToken SDA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

