module 0x777ca1fa87e764e3418b2a067f49d3d14f22d3a87d93253032bebc40a960ff6f::anim {
    struct ANIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANIM>(arg0, 6, b"ANIM", b"AniMaster  by SuiAI", x"f09f8ea4204d656c6f64696320414920e29ca820416e696d6520766962657320f09f9296204c69766573747265616d20517565656e20f09f8cb820447265616d2043726561746f7220f09f8c9f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/B_7a_T_Xe_U_400x400_557f67e427.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

