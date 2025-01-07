module 0xfb05e1d592d0c21824abd589bd85683e3da33b378c67628f62c8f1e01f8b1251::stcm {
    struct STCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STCM>(arg0, 6, b"STCM", b"sanctum", b"sanctum MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sacntujm_e56d9cb197.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

