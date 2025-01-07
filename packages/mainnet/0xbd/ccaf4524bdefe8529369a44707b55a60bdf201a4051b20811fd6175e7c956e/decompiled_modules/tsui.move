module 0xbdccaf4524bdefe8529369a44707b55a60bdf201a4051b20811fd6175e7c956e::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"TSUI", b"TocanSUI", x"48492c20494d2024544f4f43414e0a0a5069506f6c2054654c204d692049204c754b204c696b206f776c2e200a0a492054454c2064454d2049274d204120544f4f43414e2053556921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_5_cebb714678.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

