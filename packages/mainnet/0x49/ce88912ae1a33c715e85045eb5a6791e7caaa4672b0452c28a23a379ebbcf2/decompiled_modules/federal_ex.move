module 0x49ce88912ae1a33c715e85045eb5a6791e7caaa4672b0452c28a23a379ebbcf2::federal_ex {
    struct FEDERAL_EX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEDERAL_EX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEDERAL_EX>(arg0, 9, b"FEDEX", b"federal ex", b"Where now meets next. Looking for help? Tweet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1958212957780705280/o3O1d1H__400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEDERAL_EX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEDERAL_EX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

