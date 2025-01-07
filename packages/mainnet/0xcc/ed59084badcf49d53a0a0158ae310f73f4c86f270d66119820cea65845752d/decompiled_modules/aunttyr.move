module 0xcced59084badcf49d53a0a0158ae310f73f4c86f270d66119820cea65845752d::aunttyr {
    struct AUNTTYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUNTTYR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUNTTYR>(arg0, 6, b"AuntTyr", b"AuntTyrSUI", b"https://x.com/KhaokheowZoo/status/1845313682143871180", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018307_3cda47a64a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUNTTYR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUNTTYR>>(v1);
    }

    // decompiled from Move bytecode v6
}

