module 0xf6c98e255c05abdb3e7ad7f82d7a979efe29c2aa3ca485ca73921a67933590d0::ssspaw {
    struct SSSPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSPAW>(arg0, 6, b"SSSPAW", b"FomoFactory", b"Time is running and passing quick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_S_Rj_K0_HM_400x400_443842a899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSPAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSPAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

