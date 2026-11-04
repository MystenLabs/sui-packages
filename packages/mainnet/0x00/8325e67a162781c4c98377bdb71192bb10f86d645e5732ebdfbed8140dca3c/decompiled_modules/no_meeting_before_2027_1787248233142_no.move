module 0x8325e67a162781c4c98377bdb71192bb10f86d645e5732ebdfbed8140dca3c::no_meeting_before_2027_1787248233142_no {
    struct NO_MEETING_BEFORE_2027_1787248233142_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO_MEETING_BEFORE_2027_1787248233142_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO_MEETING_BEFORE_2027_1787248233142_NO>(arg0, 0, b"NO_MEETING_BEFORE_2027_1787248233142_NO", b"NO_MEETING_BEFORE_2027_1787248233142 NO", b"NO_MEETING_BEFORE_2027_1787248233142 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NO_MEETING_BEFORE_2027_1787248233142_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO_MEETING_BEFORE_2027_1787248233142_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

