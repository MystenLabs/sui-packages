module 0x9982c0cba7e2b17ad7cb95275ade0b91d97178a4929edac026f6a57bb88bf327::pam {
    struct PAM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAM>>(0x2::coin::mint<PAM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FQm_PV_Cce_WA_Ect_Kt_G9c1_Q_Eg_HU_Km_U_Dep_Lcf7_T_Djy_K_Juj_P_Dn_Mo_8db65e4cd2.jpg&w=640&q=75                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PAM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PAM     ")))), trim_right(b"SuiPam                          "), trim_right(b"Pam the bird.                                                                                                                                                                                                                                                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PAM>>(0x2::coin::mint<PAM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

