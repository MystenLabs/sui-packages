module 0x3d0774661db01f4899b0ad843134ee37a4257ca6c8ce533c200d073ec9a7b6bf::angler {
    struct ANGLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGLER>(arg0, 6, b"ANGLER", b"AnglerSUI", x"7072657061726520666f722024414e474c45520a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Angler_SUI_f3373a555a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

