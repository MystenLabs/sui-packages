module 0x4c6a65c740e27218066bf6e054b0af739b965350df94e67e9aca3a64563d323c::fartaura {
    struct FARTAURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTAURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTAURA>(arg0, 6, b"FARTAURA", b"Sui Fart Aura", b"The legacy FARTAURA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlog6wangnjqnispepdy4gwoxn4dzizq5gp5v4enz3iawboiyak4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTAURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTAURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

