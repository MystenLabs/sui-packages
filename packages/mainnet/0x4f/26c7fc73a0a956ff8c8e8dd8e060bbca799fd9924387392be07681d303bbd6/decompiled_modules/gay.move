module 0x4f26c7fc73a0a956ff8c8e8dd8e060bbca799fd9924387392be07681d303bbd6::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 6, b"GAY", b"CRASH IS FUCKING GAY", x"4655434b20594f552043524153480a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_H6eyu_X0_A_Am_WE_2_08a3fb7798.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

