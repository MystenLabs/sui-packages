module 0x3f81a93d3539b1ff40897700d2093ce2121c89ba64ac03c8c12e7e27fffb3af5::selfie {
    struct SELFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFIE>(arg0, 6, b"SELFIE", b"SELFIE dog", b"just a dog taking a selfie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/selfie_dog_29808989f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

