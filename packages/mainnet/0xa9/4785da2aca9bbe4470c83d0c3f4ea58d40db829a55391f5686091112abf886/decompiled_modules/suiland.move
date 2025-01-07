module 0xa94785da2aca9bbe4470c83d0c3f4ea58d40db829a55391f5686091112abf886::suiland {
    struct SUILAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAND>(arg0, 6, b"SUILAND", b"LANDS OF SUI NETWORK", b"$SUILAND is the digital realm that oversees the entire Sui network. In this futuristic land, everything is managed with precision and control. Join $SUILAND and take your place in the cyberland that powers the Sui universe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiland_8f457606a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

