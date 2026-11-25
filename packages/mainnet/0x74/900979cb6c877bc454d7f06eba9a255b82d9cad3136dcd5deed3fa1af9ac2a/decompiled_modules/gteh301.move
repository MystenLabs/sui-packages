module 0x74900979cb6c877bc454d7f06eba9a255b82d9cad3136dcd5deed3fa1af9ac2a::gteh301 {
    struct GTEH301 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEH301, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEH301>(arg0, 9, 0x1::string::utf8(b"GTEH301"), 0x1::string::utf8(b"BIGGEST Emmy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iHXpiYX-h5tsQJ0tF7lEMaaGgtVuClxnyLCH88LN6SnWL_bgn8tkZ1YkhAPJM4RzOEovKdJ5l3j0yHdznOkAv6P5M90C-T31MrOZCDXxDo8PIrBYQBVjR-MU87ApHDHLKOZwaLtAza3zLN7xraGgRAgShW_yppgnHFt4beOITGYT5GX-YbPQwl3LAQebDWX8psqP8JaxSU73uYF7GErcMu9cejHd-UXriTS5_MOYQNP9fPH0cGgFImsTD14TrXRW_PQ06LObQn0cw7pbr3ONVsngh8G3DFT5E8sKg8ZksoGSNGj61Pk2JHDH6e0nGrB7xGsDzN0vAq-5akHSEPbtKQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEH301>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEH301>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

