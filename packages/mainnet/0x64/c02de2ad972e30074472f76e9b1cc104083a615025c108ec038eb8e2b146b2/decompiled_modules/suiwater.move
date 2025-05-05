module 0x64c02de2ad972e30074472f76e9b1cc104083a615025c108ec038eb8e2b146b2::suiwater {
    struct SUIWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWATER>(arg0, 6, b"SUIWATER", b"WATER", b"HYDRATE YOUR BODY WITH PURE WATER, WHICH IS EXTRACTED FROM THE DEEPEST DEPTHS OF THE PLANET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/botella_agua_2942342_86d099e377.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

