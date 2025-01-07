module 0x24556ad226e8efcdaea8b7c06e8b88af04525a1bf34a13388bc3ffc4d4446d59::why {
    struct WHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHY>(arg0, 6, b"WHY", b"Shy the hamster", b"I thought we were going to the moon... now I'm just down here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_142317_91e203b20c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

