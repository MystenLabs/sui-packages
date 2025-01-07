module 0x87f059d415e04a39804dc345e016f7ac768a6e16e36688a1254b29128d5716c8::pcorn {
    struct PCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCORN>(arg0, 6, b"PCORN", b"PUMPCORN", b"Sit back with a basket of popcorn and stack your bags with $PUMPCORN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa94b7f6_ba69_42c8_8901_d5fe4bafda35_dbcf1febe4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

