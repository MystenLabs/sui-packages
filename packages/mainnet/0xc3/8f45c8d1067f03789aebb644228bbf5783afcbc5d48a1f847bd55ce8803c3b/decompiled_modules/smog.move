module 0xc38f45c8d1067f03789aebb644228bbf5783afcbc5d48a1f847bd55ce8803c3b::smog {
    struct SMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOG>(arg0, 6, b"Smog", b"suimog", b"$suiMOG is the internets first culture coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004599_d1bff6a3d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

