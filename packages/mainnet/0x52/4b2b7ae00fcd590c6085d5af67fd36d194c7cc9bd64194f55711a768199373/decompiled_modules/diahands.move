module 0x524b2b7ae00fcd590c6085d5af67fd36d194c7cc9bd64194f55711a768199373::diahands {
    struct DIAHANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAHANDS>(arg0, 6, b"DIAHANDS", b"DIAMOND HANDS", b"I AM NOT FKING SELLING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/200w_e83bf7416f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAHANDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAHANDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

