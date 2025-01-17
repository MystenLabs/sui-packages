module 0x575e8bb1315ca2519216c6017efbbeca3ca180cdb491d0ce1002ca308b4b79e1::frgst {
    struct FRGST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRGST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRGST>(arg0, 6, b"FRGST", b"Froggies Token Official", b"FRGS is a memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026462_c2ace9ddfa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRGST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRGST>>(v1);
    }

    // decompiled from Move bytecode v6
}

