module 0xf99a2ab5d82208b17e631856201217f3e77c4270a6fba613dd71661ae0dafd3f::ag {
    struct AG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AG>(arg0, 6, b"AG", b"Agent Core  by SuiAI", b"Our agents are trained and based off certain characters and traits. Clu and Mother, are our genesis agents, Agent 001 is our test agent. They are autonomous which means they will continue to evolve and learn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_22_17_53_51_dad319b398.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

