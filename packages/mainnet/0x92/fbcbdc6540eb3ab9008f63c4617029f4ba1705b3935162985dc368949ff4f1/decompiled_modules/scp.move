module 0x92fbcbdc6540eb3ab9008f63c4617029f4ba1705b3935162985dc368949ff4f1::scp {
    struct SCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCP>(arg0, 6, b"SCP", b"SuiCorp", b"Just another token for corporations, Its about name. Holy ch*** we are crazy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/CORP_69790ef8c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

