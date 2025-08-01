module 0xd1ccd0c37c1d8c3e0c45c0720c1b74df079552c5565531830866818648c2220f::USELESS {
    struct USELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USELESS>(arg0, 6, b"Useless Coin", b"USELESS", b"The coin that does absolutely nothing, and we're proud of it! No utility, no promises, just pure meme magic. Join the movement of embracing uselessness in a world obsessed with purpose.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/67351bbd-a91b-450a-bc34-19d2026b15b6")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USELESS>>(v0, @0x53ebfdfa2a9c38f03c0faa50d4406b479b3720cb82a334b3ea9d843b623eb3aa);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USELESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

