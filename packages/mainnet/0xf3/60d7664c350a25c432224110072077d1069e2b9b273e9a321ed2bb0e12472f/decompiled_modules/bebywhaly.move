module 0xf360d7664c350a25c432224110072077d1069e2b9b273e9a321ed2bb0e12472f::bebywhaly {
    struct BEBYWHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBYWHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBYWHALY>(arg0, 6, b"BEBYWHALY", b"WHALY", b"Memecoin sui on whaly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035137_0474fd24be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBYWHALY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBYWHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

