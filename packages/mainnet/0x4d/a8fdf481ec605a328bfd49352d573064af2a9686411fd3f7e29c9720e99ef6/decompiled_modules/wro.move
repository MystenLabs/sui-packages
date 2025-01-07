module 0x4da8fdf481ec605a328bfd49352d573064af2a9686411fd3f7e29c9720e99ef6::wro {
    struct WRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRO>(arg0, 6, b"WRO", b"Weirdo", b"WEIRDO, nothing else.. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2777_8a6e8d570f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

