module 0xcb3c388bf5d51ced34338c76745ca34b4fba3496369d9a92219a6611f7016e54::seedg {
    struct SEEDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDG>(arg0, 6, b"SEEDG", b"Seed Governance", b"SC governance token used to vote and control the decisions made by team. Fair launched on movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5803_0a9e9a8f7d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

