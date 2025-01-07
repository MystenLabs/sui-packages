module 0x58301d55a7644ccec3954b296d53ce7bcbf0a62c4579727f09e9768f7809c869::suisurf {
    struct SUISURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISURF>(arg0, 6, b"SUISURF", b"Sui Surfer", b"Surf the wave. Surf Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Surfer_1994f9d568.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

