module 0x485ae10d826a1dd30a7e46757833475553e07ddaa0d176d5fa9e02d0721d45ab::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"RUG THE BOTS", b"Dont buy, i just want to rug the bots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOTABOT_02_NVML_18_1200x1200_3358436438_7ecd4b5199.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

