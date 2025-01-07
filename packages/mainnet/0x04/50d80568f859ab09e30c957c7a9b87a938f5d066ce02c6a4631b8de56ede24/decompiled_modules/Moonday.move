module 0x450d80568f859ab09e30c957c7a9b87a938f5d066ce02c6a4631b8de56ede24::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/2517ab69-d027-4177-9dfd-c48fcc780e00/Gbzi0weWwAM2CLD.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/2517ab69-d027-4177-9dfd-c48fcc780e00/Gbzi0weWwAM2CLD.jpg"))
        };
        let v1 = b"aAKITA";
        let v2 = b"bAKITA on SUI";
        let v3 = b"cAKITA - The first dog on Moonday!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

