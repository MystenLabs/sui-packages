module 0x4efc1bbd17b37c02c7d2793d418ecbc7ac200d2c36efc69ef0eca8058a21669d::charm {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARM>(arg0, 6, b"CHARM", b"CHARMANDERSUI", b"Welcome to CharmSui, the electrifying Charmander-inspired token on the SUI blockchain! CharmSui combines the boundless fire of Charmander with the power of crypto to create a fun, community-driven ecosystem. Join us as we spark innovation, deliver unique NFTs, and bring the lightning to the blockchain world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196882_22c124e124.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

