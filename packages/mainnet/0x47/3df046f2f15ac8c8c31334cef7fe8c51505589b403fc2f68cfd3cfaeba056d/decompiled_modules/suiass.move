module 0x473df046f2f15ac8c8c31334cef7fe8c51505589b403fc2f68cfd3cfaeba056d::suiass {
    struct SUIASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIASS>(arg0, 6, b"SuiAss", b"Sui Ass", b"Dex will be paid when it bonds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FF_29_B47_F_0_BC_5_4_B91_A566_F80_F16_FB_83_AB_9600a9e3e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

