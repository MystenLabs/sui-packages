module 0x12ff0880a38a036a34ec0d1da348f88bfb0b34bed3ffef403db476e703a8981a::drthdrth {
    struct DRTHDRTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRTHDRTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRTHDRTH>(arg0, 6, b"DRTHDRTH", b"trthdrth by SuiAI", b"drthdrth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/s56nb6iie6a71_4dad8afd5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRTHDRTH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRTHDRTH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

