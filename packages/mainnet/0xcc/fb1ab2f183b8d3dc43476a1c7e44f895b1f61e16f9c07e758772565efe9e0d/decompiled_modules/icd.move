module 0xccfb1ab2f183b8d3dc43476a1c7e44f895b1f61e16f9c07e758772565efe9e0d::icd {
    struct ICD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICD>(arg0, 6, b"ICD", b"IceDog on SUI", b"Dog ain't cold!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_21s_F4_XUA_Uqs_Uy_77e7a462e0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICD>>(v1);
    }

    // decompiled from Move bytecode v6
}

