module 0x288beb169388565f45b34ea605f85b21a4429376d09832fcff4568b91f4e90d1::ctl {
    struct CTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTL>(arg0, 6, b"CTL", b"Capy Token Lanc", b"Capy Token Last is an innovative cryptocurrency created on the Sui network. This token aims to offer various advantages to its users by leveraging the secure and fast infrastructure of the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_09_21_005108_3ec3372597.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

