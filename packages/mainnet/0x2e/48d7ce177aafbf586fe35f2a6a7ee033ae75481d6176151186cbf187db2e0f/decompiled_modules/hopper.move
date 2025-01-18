module 0x2e48d7ce177aafbf586fe35f2a6a7ee033ae75481d6176151186cbf187db2e0f::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"HOPPER", b"Hopper - Grok's FROG by SuiAI", b"Hopper - Grok's FROG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7819_97722609e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOPPER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

