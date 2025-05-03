module 0xf7a87ce668a36938499e8baa166edc118128543afe0885e2842ec7d10be6ed57::droge {
    struct DROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROGE>(arg0, 6, b"DROGE", b"DROGE COIN", x"5375692069732074616e6b696e672c20736f206173206f7572206c61737420686f70652c20446f676520616e642046726f67206a6f696e656420666f7263657320616e6420626972746865642074686520756c74696d61746520646567656e2063616c6c65642044524f47452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/droge_logo_0ed0c12c81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

