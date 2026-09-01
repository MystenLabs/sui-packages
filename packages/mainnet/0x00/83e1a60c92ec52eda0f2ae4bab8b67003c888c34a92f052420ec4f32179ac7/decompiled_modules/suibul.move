module 0x83e1a60c92ec52eda0f2ae4bab8b67003c888c34a92f052420ec4f32179ac7::suibul {
    struct SUIBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUL>(arg0, 6, b"Suibul", b"SuiBull", x"54686520756c74696d6174652062756c6c697368206d656d6520746f6b656e206f6e20537569206e6574776f726b2e20506f776572656420627920547572626f732046696e616e636520666f72206869676820737065656420616e64206d6178696d756d206c69717569646974792e204a6f696e2074686520686572642c2070756d7020746865205375692065636f73797374656d2c20616e642063686172676520737472616967687420746f20746865206d6f6f6e2120f09f9a80f09f90820a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1788229158039.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

