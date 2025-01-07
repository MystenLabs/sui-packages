module 0x15b57ea2ecd8382fd3fe2cb4877780bdc347e6e641953b90179a8191ebdb8c86::capys {
    struct CAPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYS>(arg0, 6, b"CAPYS", b"CAPYS on SUI", x"546865206f70706f7274756e69747920697320636f6d696e67207665727920636c6f736520666f7220616c6c206f662075732e0a466f722024537569200a24434150595320766f777320746f207374617920746f67657468657220666f72657665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979395933.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

