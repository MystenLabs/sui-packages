module 0x4cf34e1e510ce706f54ccda899380d365dd671da23e5786fb018fa1008bff61c::b_pkh {
    struct B_PKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PKH>(arg0, 9, b"bPKH", b"bToken PKH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

