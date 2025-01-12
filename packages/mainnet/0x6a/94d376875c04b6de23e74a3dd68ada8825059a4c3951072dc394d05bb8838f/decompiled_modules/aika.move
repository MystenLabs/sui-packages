module 0x6a94d376875c04b6de23e74a3dd68ada8825059a4c3951072dc394d05bb8838f::aika {
    struct AIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIKA>(arg0, 6, b"AIKA", b"AGENT AIKA by SuiAI", b"bestfriend of aida. ready to conquer the waves in sui ai platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/472009888_624953673313709_372294308489259349_n_548b1a10b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIKA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

