module 0xc4601bae6868e650badd0f414f57d9f4bbd7eaf5060cd8f6caae51aaec0c78e7::mime {
    struct MIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIME>(arg0, 6, b"MIME", b"MIME AGENT", b"First mime agent on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dex_profile_03ce621e3b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

