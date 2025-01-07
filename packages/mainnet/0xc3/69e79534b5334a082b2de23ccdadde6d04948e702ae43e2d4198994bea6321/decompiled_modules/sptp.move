module 0xc369e79534b5334a082b2de23ccdadde6d04948e702ae43e2d4198994bea6321::sptp {
    struct SPTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPTP>(arg0, 6, b"SPTP", b"SUPERTRUMP", x"556e6c65617368696e67205472756d702061732074686520756c74696d6174652073757065726865726f2120436f6d62696e696e6720737472656e6774682c2068756d6f722c20616e6420612064617368206f6620e280987375706572706f776572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969941487.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPTP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPTP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

