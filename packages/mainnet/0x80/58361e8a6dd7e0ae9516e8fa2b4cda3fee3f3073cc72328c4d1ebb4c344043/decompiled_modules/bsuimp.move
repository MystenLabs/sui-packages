module 0x8058361e8a6dd7e0ae9516e8fa2b4cda3fee3f3073cc72328c4d1ebb4c344043::bsuimp {
    struct BSUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIMP>(arg0, 6, b"BSUIMP", b"BlastSUImpson", b"Blastoise X homer simpson. BlastSUImpson! appeared on sui town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004521_85a3bbe661.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

