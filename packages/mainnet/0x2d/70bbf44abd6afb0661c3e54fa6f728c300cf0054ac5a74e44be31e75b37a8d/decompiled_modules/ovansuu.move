module 0x2d70bbf44abd6afb0661c3e54fa6f728c300cf0054ac5a74e44be31e75b37a8d::ovansuu {
    struct OVANSUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVANSUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVANSUU>(arg0, 6, b"OVANSUU", b"Ovan suu", b"Ovan suu is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028535_e6de1fa5b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVANSUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OVANSUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

