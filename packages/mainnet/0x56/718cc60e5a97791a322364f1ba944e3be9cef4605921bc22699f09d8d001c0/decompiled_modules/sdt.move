module 0x56718cc60e5a97791a322364f1ba944e3be9cef4605921bc22699f09d8d001c0::sdt {
    struct SDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SDT>(arg0, 6, b"SDT", b"SUI Addict by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/reb_e53b6e0e1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

