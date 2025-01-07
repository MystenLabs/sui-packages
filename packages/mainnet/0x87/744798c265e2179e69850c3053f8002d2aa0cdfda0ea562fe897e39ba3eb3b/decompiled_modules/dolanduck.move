module 0x87744798c265e2179e69850c3053f8002d2aa0cdfda0ea562fe897e39ba3eb3b::dolanduck {
    struct DOLANDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLANDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLANDUCK>(arg0, 6, b"DOLANDUCK", b"Official Dolan Duck on Sui", b"Dexscreener Paid.Check here : https://dolanducksui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_7_cf59ee6fdd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLANDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLANDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

