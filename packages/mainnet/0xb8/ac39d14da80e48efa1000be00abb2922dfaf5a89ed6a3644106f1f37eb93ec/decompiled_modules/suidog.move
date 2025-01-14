module 0xb8ac39d14da80e48efa1000be00abb2922dfaf5a89ed6a3644106f1f37eb93ec::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"SUIDOG by SuiAI", x"24535549444f4720697320726561647920746f2064697665206465657020616e6420756e636f766572207468652068696464656e207472656173757265732077697468696e2023535549f09f8c8a205468652068756e7420666f72206162756e64616e636520626567696e732d206f6e6c792074686520626f6c642077696c6c207468726976652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3853_3e5f73831d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

