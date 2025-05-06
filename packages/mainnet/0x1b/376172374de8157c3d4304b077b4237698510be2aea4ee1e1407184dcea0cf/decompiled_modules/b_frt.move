module 0x1b376172374de8157c3d4304b077b4237698510be2aea4ee1e1407184dcea0cf::b_frt {
    struct B_FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FRT>(arg0, 9, b"bFRT", b"bToken FRT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

