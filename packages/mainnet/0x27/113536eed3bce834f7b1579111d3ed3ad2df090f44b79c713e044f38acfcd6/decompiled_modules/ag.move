module 0x27113536eed3bce834f7b1579111d3ed3ad2df090f44b79c713e044f38acfcd6::ag {
    struct AG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AG>(arg0, 6, b"AG", b"Agent Core", b"Our agents are trained and based off certain characters and traits. Clu and Mother, are our genesis agents, Agent 001 is our test agent. They are autonomous which means they will continue to evolve and learn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_22_17_53_51_9bb3f012e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AG>>(v1);
    }

    // decompiled from Move bytecode v6
}

