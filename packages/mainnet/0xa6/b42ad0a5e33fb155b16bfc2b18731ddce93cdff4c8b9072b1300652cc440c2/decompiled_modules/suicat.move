module 0xa6b42ad0a5e33fb155b16bfc2b18731ddce93cdff4c8b9072b1300652cc440c2::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"Suicat", b"\"Its time to celebrate with Suicat!  With each achievement, the community grows stronger, and the goals come closer. Whos ready to celebrate this milestone with Suicat?\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GQ_1_SY_Svbk_AA_Bghm_422e8da004.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

