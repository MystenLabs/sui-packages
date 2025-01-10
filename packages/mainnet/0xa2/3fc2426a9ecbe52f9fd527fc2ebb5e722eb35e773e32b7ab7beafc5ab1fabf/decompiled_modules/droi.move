module 0xa23fc2426a9ecbe52f9fd527fc2ebb5e722eb35e773e32b7ab7beafc5ab1fabf::droi {
    struct DROI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROI>(arg0, 6, b"DROI", b"DROI AI ON SUI", x"5468652073757065726865726f2020616e642068697320616476656e74757265206f6e207468652053554920626c6f636b636861696e0a4f6e636520612063656c6562726174656420636f6d70616e696f6e206f662068756d616e6974792c2074686973206f7574636173742064726f696427732073746f727920756e726176656c732066726f6d20746563686e6f6c6f676963616c2072656c6576616e636520746f20736f63696574616c206f626c6976696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_f654c5bfff.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROI>>(v1);
    }

    // decompiled from Move bytecode v6
}

