module 0xf3f0d4de272f2329e572f7d397dcf9894712435e5c4e2105532b47b22e35ecc7::sassy {
    struct SASSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASSY>(arg0, 6, b"Sassy", b"Sassy Seahorse", b"Making waves with a splash of Sass ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_ECFCC_15_6831_4059_9_BF_1_5891_FA_497147_967a277be7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

