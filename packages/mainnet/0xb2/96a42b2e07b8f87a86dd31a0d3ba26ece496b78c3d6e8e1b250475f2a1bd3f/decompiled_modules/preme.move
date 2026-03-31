module 0xb296a42b2e07b8f87a86dd31a0d3ba26ece496b78c3d6e8e1b250475f2a1bd3f::preme {
    struct PREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PREME>(arg0, 6, b"PREME", b"SuiPreme", b"SuiPreme: The blue whale meme asset on the Sui network. Where the whales belong. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1774974663027.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PREME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PREME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

