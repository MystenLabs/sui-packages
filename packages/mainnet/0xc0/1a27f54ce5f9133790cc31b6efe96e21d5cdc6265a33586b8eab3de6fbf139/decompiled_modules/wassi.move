module 0xc01a27f54ce5f9133790cc31b6efe96e21d5cdc6265a33586b8eab3de6fbf139::wassi {
    struct WASSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASSI>(arg0, 6, b"WASSI", b"WASSI SUI", x"2457415353492074686520736d6f6c2074696e672074686174206c6976657320696e20796f757220667269646765200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_70_6440c4a60e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

