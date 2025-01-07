module 0xaf888da0680f91c3ab6b3d8fe11ff6a369f71b7fff6b86e0504755613d1d5bd0::force {
    struct FORCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORCE>(arg0, 6, b"FORCE", b"CIZINU", b"allemagne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cizbaron_deddc12740.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

