module 0xd2365547ac120b27230c20b7f741e067b4d4b42e0818829850fbb87d13a2306e::badcat {
    struct BADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADCAT>(arg0, 6, b"BADCAT", b"BADCAT Coin", b"BADCAT is all about fun. While this cheeky cat might have a rebellious side, its true mission is to bring people together and spread positive energy. Join a vibrant community, grab some cool merch, play the fun FAP game, and even help real-life dogs and cats along the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_M_Ju_VYPN_Dxo3xh6_U5k_G_Vsr_Sxq_R_Pa_Lz_GN_Yun_U_Ux_GKY_6kg_415cce2e77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

