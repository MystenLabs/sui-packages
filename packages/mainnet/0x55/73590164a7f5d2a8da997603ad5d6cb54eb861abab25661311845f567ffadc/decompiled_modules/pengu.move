module 0x5573590164a7f5d2a8da997603ad5d6cb54eb861abab25661311845f567ffadc::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"PENGU PENGU", b"$PENGU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_GSJEI_0_H_400x400_574999dc8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

