module 0xc18cabde1c2f9dd887a6d6dea80a572591eb2a3130e636a122b33f36740ddcae::gupps {
    struct GUPPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUPPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUPPS>(arg0, 6, b"GUPPS", b"Guppy fish", b"Cutest Fish on aquarium and ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigf7hpkqqmws3obvdeuipmpwso2p6sodsbnjmlah45prwmilg5jka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUPPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUPPS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

