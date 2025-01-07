module 0x2ac5fce84418db2a806d6efc515e4460580c3ee68b5d6b9e81f3a58b861fd28::aig {
    struct AIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIG>(arg0, 6, b"AIG", b"AI AGENT", b"Welcome to the world of Agent AI, where AI super spies not only save the world but also protect your wallet! Equipped with cutting-edge technology from Sui, Agent AI is your indispensable companion on the journey to conquer the blockchain universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rsz_1a505a59708162e2a1044c095752f72a1e0868af974253f5bf2e40ac297b86c8a_1c004d9e24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

