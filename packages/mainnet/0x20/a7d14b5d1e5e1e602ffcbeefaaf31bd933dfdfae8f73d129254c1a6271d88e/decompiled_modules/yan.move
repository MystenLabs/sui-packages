module 0x20a7d14b5d1e5e1e602ffcbeefaaf31bd933dfdfae8f73d129254c1a6271d88e::yan {
    struct YAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YAN>(arg0, 6, b"YAN", b"Yandere Agent by SuiAI", b"Yandere Agent is a unique digital collectible and interactive gaming experience built on the Sui Network, leveraging the power of blockchain technology to deliver a thrilling, community-driven narrative. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8083_81464e6b8e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

