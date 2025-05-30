module 0x8bd7df57b32a2041b9f5843ea8b97c05a270d6b7de34d41d622a58e4c1e43594::b_vian {
    struct B_VIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_VIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_VIAN>(arg0, 9, b"bVIAN", b"bToken VIAN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_VIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_VIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

