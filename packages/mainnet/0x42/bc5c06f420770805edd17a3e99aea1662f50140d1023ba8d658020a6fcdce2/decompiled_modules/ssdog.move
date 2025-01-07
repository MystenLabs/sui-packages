module 0x42bc5c06f420770805edd17a3e99aea1662f50140d1023ba8d658020a6fcdce2::ssdog {
    struct SSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSDOG>(arg0, 6, b"Ssdog", b"sui Shape dog", b"let me do it for u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_Z1_JWDA_3_07e591d7e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

