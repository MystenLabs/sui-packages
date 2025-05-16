module 0xd73c7749dba69c151111e5dd6f00d2bd8b36cac9c15155c56dc9043c4893525f::HELLY {
    struct HELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLY>(arg0, 6, b"HELLY", b"What the helly", b"What the helly? what the hellyante ? what the hellyon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSif61cDMNPsxGS73Tf9BwC8H5L5uAz18iKBp41KchM8T")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

