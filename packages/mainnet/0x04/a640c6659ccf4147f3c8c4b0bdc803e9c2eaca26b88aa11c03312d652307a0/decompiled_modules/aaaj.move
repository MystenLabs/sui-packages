module 0x4a640c6659ccf4147f3c8c4b0bdc803e9c2eaca26b88aa11c03312d652307a0::aaaj {
    struct AAAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAJ>(arg0, 6, b"AAAJ", b"AAA I JEETED AGAIN", x"61616120696d2061206a65656565656565740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qf_Q_hzrf_400x400_c6ff162195.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

