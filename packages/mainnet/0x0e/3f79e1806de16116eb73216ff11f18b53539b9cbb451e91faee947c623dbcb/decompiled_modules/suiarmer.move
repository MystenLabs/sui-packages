module 0xe3f79e1806de16116eb73216ff11f18b53539b9cbb451e91faee947c623dbcb::suiarmer {
    struct SUIARMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARMER>(arg0, 6, b"SUIARMER", b"Suiarmer", b"It ain't much but it's honest work ~ your favorite farmer on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_Q3_W_Ud_Ez_400x400_ca48fb2351.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIARMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

