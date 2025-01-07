module 0xb931f3cf0172e3401b18ef58ce4ad801af41dfd2a0c3d249d32d31907ea64f91::albie {
    struct ALBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALBIE>(arg0, 6, b"Albie", x"416c626965e280997320536e6f777920447265616d", b"This snow leopard is watching you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732519996507.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALBIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALBIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

