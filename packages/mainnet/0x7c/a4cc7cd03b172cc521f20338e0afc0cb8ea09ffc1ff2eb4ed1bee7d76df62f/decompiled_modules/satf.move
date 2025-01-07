module 0x7ca4cc7cd03b172cc521f20338e0afc0cb8ea09ffc1ff2eb4ed1bee7d76df62f::satf {
    struct SATF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATF>(arg0, 6, b"SATF", b"SATOSHI FACE", b"SATOSHI REVEAL BY HBO (target 1 billion)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_132308_cb45cb4a73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATF>>(v1);
    }

    // decompiled from Move bytecode v6
}

