module 0xd6fbc74198908767119b39da1a2fe0a5ca0f16cf02eeab5e1a443aa894d88af9::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"Kirby Sui", x"537569206d656d6520636f696e0a57686f206973206b69726279203b0a0a68747470733a2f2f656e2e6d2e77696b6970656469612e6f72672f77696b692f4b697262795f28636861726163746572290a0a576562736974653a2068747470733a2f2f6b697262797375692e78797a2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027958_d30b74edd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

