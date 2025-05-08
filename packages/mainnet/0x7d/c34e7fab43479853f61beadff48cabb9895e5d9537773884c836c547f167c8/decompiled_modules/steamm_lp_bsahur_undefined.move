module 0x7dc34e7fab43479853f61beadff48cabb9895e5d9537773884c836c547f167c8::steamm_lp_bsahur_undefined {
    struct STEAMM_LP_BSAHUR_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSAHUR_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSAHUR_UNDEFINED>(arg0, 9, b"STEAMM LP bSAHUR-undefined", b"STEAMM LP Token bSAHUR-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSAHUR_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSAHUR_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

