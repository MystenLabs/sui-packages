module 0x824c1f36ce9d937b843a6cccdbd784db0dcbbc6e188a1155ec902cb4f0f18ef6::hebi {
    struct HEBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEBI>(arg0, 6, b"HEBI", b"$HEBI", b"$HEBI is the cutest snake on Sui blockchain come to building the strong community ever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfpcoin_26e67f244b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

