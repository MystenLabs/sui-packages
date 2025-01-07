module 0xa9a725d8cf0aff9cc4fdffdb34bc2610fc5bea74545108c73fad95db6365c0ab::deepmon {
    struct DEEPMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPMON>(arg0, 6, b"DEEPMON", b"DeepBook Monkey", b"https://x.com/DeepBookonSui/status/1843202433624768712", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Re1zi_W4_AE_7_X1_E_1c3b0fe637.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

