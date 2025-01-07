module 0x7e34ef1db448faf46f61da34bf907e6807183ef5b6c5a39d6b5cdb7b93502acb::penf {
    struct PENF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENF>(arg0, 6, b"PENF", b"PENSIVE FISH", x"57656c636f6d6520746f2050656e7369766520466973682c746865206d656d65636f696e20746861742773206d6f76696e672074686520776f726c6420210a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_29_5576ba68ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENF>>(v1);
    }

    // decompiled from Move bytecode v6
}

