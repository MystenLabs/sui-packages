module 0xa6bce0276bc9d82abeec7d3d2293c05e2de0d37d84a1569aa6675489e870b71b::PIGWIG {
    struct PIGWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGWIG>(arg0, 6, b"PIGWIG", b"Pig with a wig", b"Just a pig (john pork) with a wig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmer63xsg2dYLHZpwH3ZDTrByvw2Tqs1eHZmVk9Yhf9dag")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIGWIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGWIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

