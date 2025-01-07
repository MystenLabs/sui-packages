module 0xfbddbfc2ee8b4549e722488243cdacdfbe0df8815a4c038d6f39bcb4730810cc::gptx {
    struct GPTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GPTX>(arg0, 6, b"GPTX", b"GPTX", b"Our team will train this Agent to buy on DEXCELERATE the new hyped tokens . Act like a degen sniper . See our website and team   www,hedge4,Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hedge4_logo_152f15a283.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GPTX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPTX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

