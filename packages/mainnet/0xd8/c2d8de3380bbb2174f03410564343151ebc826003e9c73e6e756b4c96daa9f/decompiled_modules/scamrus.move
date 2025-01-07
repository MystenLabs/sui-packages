module 0xd8c2d8de3380bbb2174f03410564343151ebc826003e9c73e6e756b4c96daa9f::scamrus {
    struct SCAMRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMRUS>(arg0, 6, b"SCAMRUS", b"SCAM RUSSIA", b"Just scamming you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1552243922_preview_Scammer_395a867bb6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAMRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

