module 0x6008afbbace03fb4590f7f713726eb174ae5095c3cf6122b2a2a919338c1dbfa::bald {
    struct BALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALD>(arg0, 6, b"BALD", b"SUIAROW", b"BALD HAROWSUI LAUNCH ON SOLANA NEXT FEW HOLIDAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999376215.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

