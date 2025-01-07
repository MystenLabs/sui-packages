module 0x62671a3dcc3019fc1ca1f4f8eec1b62d917b54ff03e2d183129e0b128ed8513c::desci {
    struct DESCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESCI>(arg0, 6, b"DESCI", b"SUI Desci Agents", b"SUI Desci Agents is a layer revolutionizing longevity science by launching tokenized compounds, promoting them with AI agents, and implementing advanced liquidity mechanics inspired by Pump.fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734981684976.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DESCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

