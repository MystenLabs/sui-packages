module 0x5125e0ced75f53daa7fa37cf0a6b95ef66502f9d68853ebd21ebd39b32c3d9e9::degens {
    struct DEGENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENS>(arg0, 6, b"DEGENS", b"DEGEN SUI", b"DEGEN IN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240613_053346_949_86331276f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

