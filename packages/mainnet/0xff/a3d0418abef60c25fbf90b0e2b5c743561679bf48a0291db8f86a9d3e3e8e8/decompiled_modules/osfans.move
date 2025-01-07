module 0xffa3d0418abef60c25fbf90b0e2b5c743561679bf48a0291db8f86a9d3e3e8e8::osfans {
    struct OSFANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSFANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSFANS>(arg0, 6, b"OSfans", b"OnlySuiFans", b"OnlySuiFans for all the memes on the sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_52_17fe1dee55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSFANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSFANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

