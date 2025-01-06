module 0x1f9cfe1fc85a1f6974ad59fe2b2cb75109587a16e13f73dc9020f87c9df48219::trai {
    struct TRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRAI>(arg0, 6, b"TRAI", b"tronai by SuiAI", b"Launch and Co-Create Onchain AI Agents @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Picture22_94de95_0ed7f27808.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

