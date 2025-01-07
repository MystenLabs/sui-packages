module 0xf44330cea25cf3abcd6e48d7876eb96dfa37899722607038a9c78dde06364fb9::so {
    struct SO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SO>(arg0, 6, b"SO", b"Storm Octopus", b"Storm Octopus on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giant_8521503_1280_74914edaa3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SO>>(v1);
    }

    // decompiled from Move bytecode v6
}

