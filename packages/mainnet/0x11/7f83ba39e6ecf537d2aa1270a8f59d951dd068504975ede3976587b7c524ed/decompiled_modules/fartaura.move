module 0x117f83ba39e6ecf537d2aa1270a8f59d951dd068504975ede3976587b7c524ed::fartaura {
    struct FARTAURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTAURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTAURA>(arg0, 6, b"FARTAURA", b"Sui Fart Aura", b"pump the farts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4o6rqfyk3ud4itvg3e4xrg5clygz4ilzujkk2rsyajvgyaui3di")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTAURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTAURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

