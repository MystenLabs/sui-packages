module 0x5a88f39e3aa11a5039424113d847ac15b20800a9c441ef7a06bf63622c54a803::rick {
    struct RICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICK>(arg0, 6, b"RICK", b"SUIRICK", x"4d616420536369656e7469737420696e20537569206e6574776f726b200a5375695269636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197682_85d8cb45cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

