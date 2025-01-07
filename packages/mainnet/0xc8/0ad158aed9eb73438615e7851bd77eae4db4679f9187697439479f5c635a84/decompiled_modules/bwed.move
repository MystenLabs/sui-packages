module 0xc80ad158aed9eb73438615e7851bd77eae4db4679f9187697439479f5c635a84::bwed {
    struct BWED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWED>(arg0, 6, b"BWED", b"BWEDonSUI", b"rawwrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bwed_14b2afbb8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWED>>(v1);
    }

    // decompiled from Move bytecode v6
}

