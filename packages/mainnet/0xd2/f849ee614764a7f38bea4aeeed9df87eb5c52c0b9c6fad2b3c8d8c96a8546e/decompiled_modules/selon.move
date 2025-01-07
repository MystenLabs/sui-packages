module 0xd2f849ee614764a7f38bea4aeeed9df87eb5c52c0b9c6fad2b3c8d8c96a8546e::selon {
    struct SELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELON>(arg0, 6, b"SELON", b"SUIELON", b"Elon Musk love SUI and plan to integret SUI into the XAI platform. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3807_9fbf17b641.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

