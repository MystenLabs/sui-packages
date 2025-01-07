module 0x888032039462ebaa35435b8f26189264d11ff1c94283880aba0d56d8fb981625::cduck {
    struct CDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDUCK>(arg0, 6, b"CDUCK", b"Captain Duck", b"The Captain duck on SUI is in duty to pump the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cduck_0cc5469845.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

