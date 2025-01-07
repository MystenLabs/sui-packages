module 0xe8489263eb859fbeb4fef479912bae1ea47be7674a73c51459a127c4a9bc3e7a::hawktoshi {
    struct HAWKTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKTOSHI>(arg0, 6, b"HAWKTOSHI", b"Hawktoshi Tuahmoto", b"HBO was wrong I am Hawktoshi Tuahmoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hawkk_7710762e93.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

