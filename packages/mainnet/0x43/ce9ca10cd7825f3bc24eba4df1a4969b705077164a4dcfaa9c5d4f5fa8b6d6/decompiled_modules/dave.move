module 0x43ce9ca10cd7825f3bc24eba4df1a4969b705077164a4dcfaa9c5d4f5fa8b6d6::dave {
    struct DAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVE>(arg0, 6, b"DAVE", b"Dave", b"just dave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dave_3deedba04a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

