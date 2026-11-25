module 0xe3c94321f1d17453b1cac21fffc65acf7ac31c0a589a4c5526e77561279aeb6f::gtllyd1 {
    struct GTLLYD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLLYD1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLLYD1>(arg0, 9, 0x1::string::utf8(b"GTLLYD1"), 0x1::string::utf8(b"JL"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/WuTEQrKZ6uAVP_E7PtiUr0z658hgowqqSHIrrkOs_hIx5kWUBfduq4XZSdaSYDtxeOCLX09znMxr26KjLS8ztZkF7h0t4_x4kZkOX6ILf3rbefw5Baomw46SqiZdx9yXKGaQ5cXNV531yMUyWPJFZfG_P80DWvlwlCYjGa5mSgrC_dLDT63FBwyCCKr4QdoqNAL81LDFmJSd2GnIEEpnb_o7bfOhLxkVf4TWAQloNslEJJuY_c3a0anHH6VrPAKLLKD_4GZG2Hgq3NrSqNjkrng8Wk70GIJ4pHBI-ZgDya-FCNhpK7bR9qCHm0KUBRafEOHw4pFxNP-gifX3I5b02g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLLYD1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLLYD1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

