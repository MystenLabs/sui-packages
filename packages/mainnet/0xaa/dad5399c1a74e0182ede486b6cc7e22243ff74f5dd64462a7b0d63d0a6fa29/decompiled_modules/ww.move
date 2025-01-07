module 0xaadad5399c1a74e0182ede486b6cc7e22243ff74f5dd64462a7b0d63d0a6fa29::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW>(arg0, 6, b"WW", b"WOW", b"Wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008633_b5b0de0772.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WW>>(v1);
    }

    // decompiled from Move bytecode v6
}

