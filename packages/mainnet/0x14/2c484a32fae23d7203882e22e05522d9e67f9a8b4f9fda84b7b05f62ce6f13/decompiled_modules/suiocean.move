module 0x142c484a32fae23d7203882e22e05522d9e67f9a8b4f9fda84b7b05f62ce6f13::suiocean {
    struct SUIOCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOCEAN>(arg0, 6, b"SUIOCEAN", b"SUI Ocean", b"SUIOCEAN is SUIOCEAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/18627812_3791_485b_a690_6447269d9970_1f14a0bc9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

