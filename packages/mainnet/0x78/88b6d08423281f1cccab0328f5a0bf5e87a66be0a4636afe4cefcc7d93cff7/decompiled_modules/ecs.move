module 0x7888b6d08423281f1cccab0328f5a0bf5e87a66be0a4636afe4cefcc7d93cff7::ecs {
    struct ECS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECS>(arg0, 6, b"ECS", b"ESCABARA SUI", b"Your bank hates us, your ex regrets us, and your wallet thanks us this is the coin for those who play the game to win ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1715_257d29fe19.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECS>>(v1);
    }

    // decompiled from Move bytecode v6
}

