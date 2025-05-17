module 0xc1f7f884ff7e4a6334479497dda26666280f32fe8da2d0226182f11885fdbab4::blaj {
    struct BLAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAJ>(arg0, 6, b"BLAJ", b"BLAHAJ", b"From your sofa to the Sui blockchain. $BLAJ is swimming in.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_ae_a_c_e_2025_05_18_004802_2b520e964d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

