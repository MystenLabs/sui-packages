module 0x8d62460b3b8fe8f25ba62c1bc40dffedba7b14137a82def0ac8f879bccca13c6::uwuwuw {
    struct UWUWUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: UWUWUW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<UWUWUW>(arg0, 6, b"UWUWUW", b"UWUWUWUW by SuiAI", b"USUSU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/shiba_inu_shib_sticker_4d6d097be9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UWUWUW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UWUWUW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

