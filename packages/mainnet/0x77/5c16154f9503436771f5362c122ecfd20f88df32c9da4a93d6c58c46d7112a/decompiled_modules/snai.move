module 0x775c16154f9503436771f5362c122ecfd20f88df32c9da4a93d6c58c46d7112a::snai {
    struct SNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SNAI>(arg0, 6, b"SNAI", b"Sui News AI by SuiAI", b"Sui News AI serves up the latest happenings in the Sui ecosystem, delivering sharp insights with a side of snark.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/J_400_x_400_px_6_e266375284.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

