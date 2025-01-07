module 0x751bc7b4d556ca53f86a6a89fc5c83af3201af9b052ad6d4d748e02e0e4ec320::sscf {
    struct SSCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSCF>(arg0, 6, b"SSCF", b"SMOKING CHICKEN FISH", b"Smoking chicken fish sui, financial freedom increase bean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1461728887562_pic_f7ee6db9ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

