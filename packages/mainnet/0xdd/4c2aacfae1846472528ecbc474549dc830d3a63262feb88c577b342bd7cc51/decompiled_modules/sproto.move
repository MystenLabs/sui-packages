module 0xdd4c2aacfae1846472528ecbc474549dc830d3a63262feb88c577b342bd7cc51::sproto {
    struct SPROTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPROTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPROTO>(arg0, 6, b"SPROTO", b"Sproto Gremlin", b"Sproto Gremlins are deep manifestations of the harrypotterobamasonic10inu's egregore. Imbued with high speed presidential wizardry and lifelong loyalty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6671ae74a6352c82d50a1df7_1718726262_b0c7d4afad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPROTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPROTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

