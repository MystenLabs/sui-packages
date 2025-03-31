module 0x4f49a94c04e81d4033e870968649d93a3e6623827c0bc34056746b221ed77174::rigaz {
    struct RIGAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIGAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIGAZ>(arg0, 6, b"RIGAZ", b"Rigaz", b"Rigaz is a strong memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052653_8ef86fcf32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIGAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIGAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

