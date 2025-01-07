module 0x69d7b56192c85eabf71b6c04a0f766c9cab4f4cfd59ceee984be0da73390140d::link {
    struct LINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINK>(arg0, 6, b"LINK", b"Link", b"LinkForge is an innovative project aimed at introducing the popular Blink protocol from the Solana ecosystem to the Sui blockchain. This initiative goes beyond mere technical migration; it represents a pioneering attempt at cross-chain collaboration, designed to offer Sui users a richer and more intuitive blockchain interaction experience. By integrating the Blink protocol, LinkForge will provide users with a unique, SBT-based (Soul-Bound Token) personal showcase platform, while simultaneously driving the development of the Sui ecosystem and enhancing cross-chain interoperability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_CORAL_5b388f4dd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

