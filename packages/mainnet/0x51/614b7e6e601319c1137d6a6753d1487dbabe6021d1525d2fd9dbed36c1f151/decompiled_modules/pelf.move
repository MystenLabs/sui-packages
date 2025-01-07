module 0x51614b7e6e601319c1137d6a6753d1487dbabe6021d1525d2fd9dbed36c1f151::pelf {
    struct PELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELF>(arg0, 6, b"PELF", b"PELF SUI", x"2074686520616c7465722065676f206f6620504550452074686174206c6976657320696e2066616972792074616c652c20666f726576657220796f756e6720616e6420616c6c7572696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_77_06f4f0e1bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

