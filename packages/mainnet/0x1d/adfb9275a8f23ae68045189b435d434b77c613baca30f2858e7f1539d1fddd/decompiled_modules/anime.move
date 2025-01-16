module 0x1dadfb9275a8f23ae68045189b435d434b77c613baca30f2858e7f1539d1fddd::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANIME>(arg0, 6, b"ANIME", b"AniMaster  by SuiAI", x"f09f8ea4204d656c6f64696320414920e29ca820416e696d6520766962657320f09f9296204c69766573747265616d20517565656e20f09f8cb820447265616d2043726561746f7220f09f8c9f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/w_Ib9q6_AZ_400x400_1_c1dad9d3d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANIME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

