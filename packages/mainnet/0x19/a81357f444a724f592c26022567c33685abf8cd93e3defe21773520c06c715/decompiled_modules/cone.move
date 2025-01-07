module 0x19a81357f444a724f592c26022567c33685abf8cd93e3defe21773520c06c715::cone {
    struct CONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONE>(arg0, 6, b"CONE", b"SuiCone", b"CONE on SUI making a splash! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CONESPLASH_4702fe4c3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

