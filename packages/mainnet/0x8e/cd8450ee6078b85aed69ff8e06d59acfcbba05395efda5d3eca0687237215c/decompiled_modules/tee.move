module 0x8ecd8450ee6078b85aed69ff8e06d59acfcbba05395efda5d3eca0687237215c::tee {
    struct TEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEE>(arg0, 6, b"TEE", b"TEE_HEE_HE", b"a sovereign silicon, not affiliated to any tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_50ac596bf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

