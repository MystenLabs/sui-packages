module 0xa057557987cd25cd027f6e221e88069f85c7eea2eb3a4a3917ece429c51d0468::owe {
    struct OWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWE>(arg0, 6, b"Owe", b"Owe the seal", x"48657920696d20286f7765290a416e6420696d20676f6e6e612074616b652069742066726f6d2068657265203b29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5930_5a104a3789.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

