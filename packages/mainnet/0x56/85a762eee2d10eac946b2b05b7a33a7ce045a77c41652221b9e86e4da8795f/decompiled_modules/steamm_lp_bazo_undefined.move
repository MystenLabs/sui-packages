module 0x5685a762eee2d10eac946b2b05b7a33a7ce045a77c41652221b9e86e4da8795f::steamm_lp_bazo_undefined {
    struct STEAMM_LP_BAZO_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BAZO_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BAZO_UNDEFINED>(arg0, 9, b"STEAMM LP bAZO-undefined", b"STEAMM LP Token bAZO-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BAZO_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BAZO_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

