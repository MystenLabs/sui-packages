module 0x699d93cfab6975a48d5d5e364de87de5f03427bdfc613087b8f17eec1e997c9c::steamm_lp_bksui_undefined {
    struct STEAMM_LP_BKSUI_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKSUI_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKSUI_UNDEFINED>(arg0, 9, b"STEAMM LP bKSUI-undefined", b"STEAMM LP Token bKSUI-undefined", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKSUI_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKSUI_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

