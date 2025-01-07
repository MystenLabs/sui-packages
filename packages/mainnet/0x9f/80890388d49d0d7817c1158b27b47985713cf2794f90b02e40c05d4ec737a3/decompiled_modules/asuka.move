module 0x9f80890388d49d0d7817c1158b27b47985713cf2794f90b02e40c05d4ec737a3::asuka {
    struct ASUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUKA>(arg0, 9, b"ASUKA", b"Asuka", b"ASUKA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/078/510/815/large/fugui-ding-020.jpg?1722319220")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASUKA>(&mut v2, 5000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

