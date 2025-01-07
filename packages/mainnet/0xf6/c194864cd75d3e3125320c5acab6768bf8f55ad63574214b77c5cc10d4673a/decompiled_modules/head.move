module 0xf6c194864cd75d3e3125320c5acab6768bf8f55ad63574214b77c5cc10d4673a::head {
    struct HEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAD>(arg0, 6, b"HEAD", b"HEAD SUI", b"big ego, huge gains & a super fat $head", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gm_Nm_5kg_400x400_0071439fae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

