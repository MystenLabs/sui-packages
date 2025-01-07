module 0x2fa4a923680bf519ef3bb489369074d27c0d3e87661fce7eacba7d63dd3edec2::gigageek {
    struct GIGAGEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGAGEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGAGEEK>(arg0, 6, b"GIGAGEEK", b"GiGaGeek", x"474947414745454b2028474947414745454b290a746f20746865206d6f6f6e20616e64206265796f756e64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rbutsd_Zf5hm8gg_Upm_Q7_Uu9_P18ntez_SD_4_Za_ALFN_96ot_GC_5ba52ca577.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGAGEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGAGEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

