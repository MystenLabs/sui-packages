module 0xf15f1d6b6d3d1dc59d3939ce4e4084d6874d4f8d0d3d3a4f200dc6319fb10447::dgold {
    struct DGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGOLD>(arg0, 6, b"DGold", b"Doge Gold", b"If you know,you know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001668008_55b9ef4a57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

