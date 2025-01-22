module 0x6173dcdcc6aae21a9d522fdd861dc9506f5d219ef378dac2cc9453e7fee9ee24::devian {
    struct DEVIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVIAN>(arg0, 6, b"DEVIAN", b"Devian On Sui", x"4c65742773206578706c6f726520746865206c696d69746c65737320706f74656e7469616c206f662074686973206d656d6520636f696e20746f67657468657220616e64206265636f6d652070617274206f66206f75722076696272616e7420636f6d6d756e6974792e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Na_i_dung_Ae_oa_n_v_Ae_n_ba_n_ca_a_ba_n_18e230db91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

