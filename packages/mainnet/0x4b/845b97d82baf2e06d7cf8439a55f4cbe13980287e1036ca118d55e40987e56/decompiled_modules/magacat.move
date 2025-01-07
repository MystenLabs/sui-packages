module 0x4b845b97d82baf2e06d7cf8439a55f4cbe13980287e1036ca118d55e40987e56::magacat {
    struct MAGACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGACAT>(arg0, 6, b"MAGACAT", b"MAGA CAT", b"Welcome to the purr-fect blend of fun and finance with MAGACAT! This memecoin is more than just a playful nod to our feline friends; it embodies the spirit of community, humor, and creativity in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_26_191333_e84b9802c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

