module 0x31a7c175ef556af24eb0da2f112b57280b72b95ee5cbc6a0d65ec31bace666bf::rck {
    struct RCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCK>(arg0, 6, b"RCK", b"RICK", b"Mad Scientist in Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197682_021709bb31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

