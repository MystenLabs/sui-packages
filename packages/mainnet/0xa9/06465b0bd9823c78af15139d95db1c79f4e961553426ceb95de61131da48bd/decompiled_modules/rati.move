module 0xa906465b0bd9823c78af15139d95db1c79f4e961553426ceb95de61131da48bd::rati {
    struct RATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RATI>(arg0, 6, b"RATI", b"RATI by SuiAI", b"RATI RATI RATI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_08_at_6_36_47_PM_c515e9d146.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RATI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

