module 0xa1aa9e084a7b531a43910a57fa25aa5f9dfefe11dc046863202279615ccc6746::fengsuidog {
    struct FENGSUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENGSUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGSUIDOG>(arg0, 6, b"FENGSUIDOG", b"FENG SUI DOGS", b"The most relaxed dogs in the whole SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4d5f1dbb_3d9b_42c1_80a3_744a98247f9f_7ecbde9bd8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGSUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENGSUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

