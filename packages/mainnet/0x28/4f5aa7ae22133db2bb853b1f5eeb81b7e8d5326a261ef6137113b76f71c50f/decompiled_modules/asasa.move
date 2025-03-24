module 0x284f5aa7ae22133db2bb853b1f5eeb81b7e8d5326a261ef6137113b76f71c50f::asasa {
    struct ASASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASASA>(arg0, 6, b"ASASA", b"asas", b"asasa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_YT_ad31e8a116.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

