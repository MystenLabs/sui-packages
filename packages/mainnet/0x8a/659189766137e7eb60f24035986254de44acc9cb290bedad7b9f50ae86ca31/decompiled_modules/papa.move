module 0x8a659189766137e7eb60f24035986254de44acc9cb290bedad7b9f50ae86ca31::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 6, b"PAPA", b"PAPA  on sui", b"Excellent super duper fun meme.all bro.small amount buying ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4982668e0997f679b82641c4af34f708blob_d9eacc0e3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

