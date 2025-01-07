module 0xbada2cfa6f2412fc0b0f52e164a16421538691c98fc66213d2353a91b53acdd0::air {
    struct AIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR>(arg0, 6, b"AIR", b"AirFish Pro", b"Coming Out September 28th moon sold separately ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screen_Shot_Tool_20240927223609_4ec8410522.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

