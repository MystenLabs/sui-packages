module 0xff444a71de424c84b19045b700c54c75553ba88a9ff884067cc85c8b0aada9b8::buff {
    struct BUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFF>(arg0, 6, b"BUFF", b"Suicken", b"The $SUI Chicken.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_b9876781db.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

