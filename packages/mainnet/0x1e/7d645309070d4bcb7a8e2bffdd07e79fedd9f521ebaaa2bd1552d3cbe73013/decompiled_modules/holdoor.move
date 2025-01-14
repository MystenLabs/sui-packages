module 0x1e7d645309070d4bcb7a8e2bffdd07e79fedd9f521ebaaa2bd1552d3cbe73013::holdoor {
    struct HOLDOOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLDOOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLDOOR>(arg0, 6, b"HOLDoor", b"Holder Head", b"HODL the Door", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736826668939.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLDOOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLDOOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

