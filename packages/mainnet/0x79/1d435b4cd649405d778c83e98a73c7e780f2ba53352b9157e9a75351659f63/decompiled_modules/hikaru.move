module 0x791d435b4cd649405d778c83e98a73c7e780f2ba53352b9157e9a75351659f63::hikaru {
    struct HIKARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKARU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIKARU>(arg0, 6, b"HIKARU", b"Hikaru a16z by SuiAI", b"Your delivery AI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3852_8fac7837da.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIKARU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIKARU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

