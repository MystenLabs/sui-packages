module 0xdfe5e83304b0a2f30712754c175a8324b088a263f9a419dc97216c456c9d40b8::b_typus {
    struct B_TYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TYPUS>(arg0, 9, b"bTYPUS", b"bToken TYPUS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TYPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TYPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

