module 0xefd2769527a5915a3d60b5d1c5bc190e11bae6eafd103ab4a3d61ac5dde00ff5::gtooorayn {
    struct GTOOORAYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOOORAYN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOOORAYN>(arg0, 9, 0x1::string::utf8(b"GTOOORAYN"), 0x1::string::utf8(b"LEGHnd"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/BJsQMph06zknRrVbyVp0J8AaKksum-UEIHHEDKAMGQlNSu6Yab2jdn5sQ42GepVRNVFB6dQXhgmTpjOU32Z-ZGw7urL6mdMC78eDudPvVCvTUk27HJB3JMqjBVKyCuCKBwRyMKSn2OK8fX9NH-a6DX4CCICXzI-HLrQqANoOVRGdzxpx_9pREplX3Ryw3GsJvutMRt9z-wwvluu4lwsI3pOwyP8mKaNXSKmI-5hSLw91N1IkLWVoF-GfA5tyJiOWI2Sr80dSfYK9zaXq8Mh_dIcVEqQZxiTfANwKxWRsSejQfX6JrPqkgnpo7C4AxC0mxNa--noDv0aPB1YLVRcZtQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOOORAYN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOOORAYN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

