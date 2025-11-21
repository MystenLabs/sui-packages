module 0xb5a6ba5121d1631b761e8a6a673b7587cab521effa30e34cdc8acbdced9be4fc::no_wars {
    struct NO_WARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO_WARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO_WARS>(arg0, 6, b"NW", b"No Wars", b"No Wars is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO_WARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO_WARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

