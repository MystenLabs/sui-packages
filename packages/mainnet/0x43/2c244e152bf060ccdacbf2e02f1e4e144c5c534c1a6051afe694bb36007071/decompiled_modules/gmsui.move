module 0x432c244e152bf060ccdacbf2e02f1e4e144c5c534c1a6051afe694bb36007071::gmsui {
    struct GMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMSUI>(arg0, 6, b"GMSUI", b"gm sui frens", b"gm frens on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_14_74dec48a1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

