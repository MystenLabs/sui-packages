module 0x72a37cbf789be3f46d51148ee0feb22de63042950140b1883e38eeb05d614984::frosty {
    struct FROSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTY>(arg0, 6, b"FROSTY", b"SUI FROSTY", b"Frosty, as he wants to make Sui a better place decided to join the AI agents, he will be working on a version of himself (bot) that will be able to trade automatically in the Sui network, basing his decision making on the most relevant data of each token in the network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_034554_130_9722eb897f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

