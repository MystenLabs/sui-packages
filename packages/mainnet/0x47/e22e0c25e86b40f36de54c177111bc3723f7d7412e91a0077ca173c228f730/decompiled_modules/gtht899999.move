module 0x47e22e0c25e86b40f36de54c177111bc3723f7d7412e91a0077ca173c228f730::gtht899999 {
    struct GTHT899999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHT899999, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHT899999>(arg0, 9, 0x1::string::utf8(b"GTHT899999"), 0x1::string::utf8(b"Take your time Take your time"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/DaE9tusErRiKBYillOwhn3hB7fQoIkCHDJVVdVeZyNwoAjcXpfySH7JrQBlDsElY94xIRaomsWbva7j0ysJwJa63g7P9CODZf7uOQUwjKl25z-Irh7vrDRpJEZJ9AMMWIBQ073HWr2ufn7CzM-r6TKW57dCpjcr8omwG0AmwaMxoBArjp_Ql-EzjJtHO0IY8mHXsqzrUya1cCVgwjWL6m-ybXWgXbP98dEflJCkQZSc44YAPwJW7blQppdagzzQ6-fO85hjt9gRF0Y-SVWX7I5fs4oAa4bjizfEdmCyzilcXRCGUHrQ9NNevMJyCtTIjgIs2msvk93fUzI6SgFGaIw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHT899999>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHT899999>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

