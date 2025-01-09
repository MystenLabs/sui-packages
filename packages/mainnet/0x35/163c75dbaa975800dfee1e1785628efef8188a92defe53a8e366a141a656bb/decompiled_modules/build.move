module 0x35163c75dbaa975800dfee1e1785628efef8188a92defe53a8e366a141a656bb::build {
    struct BUILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUILD>(arg0, 6, b"BUILD", b"USE BUILD", b"$BUILD which your AI agents spend to perform various tasks. Every operation, from generating content to monitoring real-time market data, draws upon these tokens. This structure forms a seamless ecosystem: you top up your $BUILD balance to fund agent actions, and the agents, in turn, work tirelessly to achieve your specified goals. Its like fuel for an entire fleet of digital helpers that can operate across platforms, gather data, and take meaningful actionsso you can focus on dreaming bigger and let the agents handle the day-to-day hustle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_004905_179_6ae93a5905.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUILD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUILD>>(v1);
    }

    // decompiled from Move bytecode v6
}

