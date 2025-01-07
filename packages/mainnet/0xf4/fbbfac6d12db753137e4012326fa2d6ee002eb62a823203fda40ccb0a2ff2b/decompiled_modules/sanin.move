module 0xf4fbbfac6d12db753137e4012326fa2d6ee002eb62a823203fda40ccb0a2ff2b::sanin {
    struct SANIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANIN>(arg0, 6, b"SANIN", b"SANIN THE SUI CHIB", b"SHIB ON ETH ... SANIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_bc28c3c667.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

