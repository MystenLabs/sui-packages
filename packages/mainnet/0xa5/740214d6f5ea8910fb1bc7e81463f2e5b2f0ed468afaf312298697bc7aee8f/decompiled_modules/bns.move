module 0xa5740214d6f5ea8910fb1bc7e81463f2e5b2f0ed468afaf312298697bc7aee8f::bns {
    struct BNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNS>(arg0, 6, b"BNS", b"Brain SUI", b"Art is the beginning of life. We bring a difference that is not available anywhere else. Let's see it resplendent in the SUI system", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_28_20_34_40_0802475b1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

