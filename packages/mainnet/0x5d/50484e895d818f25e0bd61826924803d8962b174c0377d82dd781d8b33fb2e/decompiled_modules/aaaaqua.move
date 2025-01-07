module 0x5d50484e895d818f25e0bd61826924803d8962b174c0377d82dd781d8b33fb2e::aaaaqua {
    struct AAAAQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAQUA>(arg0, 6, b"AAAAQUA", b"AAAAQUAMAN", b"AAAAAAAAAAQQUAAAMANNN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54_F1_AA_56_51_F6_4970_91_B3_661140528_DC_6_960233ff7b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

