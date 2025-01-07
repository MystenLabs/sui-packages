module 0x7afab7d96d2139dd992f9349f94368da0311226d74cb8f3d744432c435f98d9f::pon {
    struct PON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PON>(arg0, 6, b"PON", b"PON COIN", b"We ArE aLl MoNkeYs WooA-woOA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7dfafd8f_574d_4059_9bc5_aad039f3b873_removebg_preview_39a6f5701e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PON>>(v1);
    }

    // decompiled from Move bytecode v6
}

