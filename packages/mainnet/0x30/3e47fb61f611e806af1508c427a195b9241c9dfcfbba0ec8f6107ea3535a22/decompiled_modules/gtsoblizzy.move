module 0x303e47fb61f611e806af1508c427a195b9241c9dfcfbba0ec8f6107ea3535a22::gtsoblizzy {
    struct GTSOBLIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSOBLIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSOBLIZZY>(arg0, 9, 0x1::string::utf8(b"GTSOBLIZZY"), 0x1::string::utf8(b"Blizart"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/rqWvmHJT22WqGqpw1gbqrEV6rSQ9BhcPHX77FdzzoXToN4jbHpGSbkZRbknVsxHglfxfkpEmxtRrqFe7TtG2f-npRjIinmXN4yQiwVJUYaUJwcRyeng2gvTiefunb08ezBUjChsFJ8NCsCsLHtyxNYzfKH4K3tNUFGTukk1Qg481FeAeS-QY9YfMsJYdrp-chYlvz4U9UNJ7KFoC8-hpZ52BpRUXNwlJJlt77BWjSYITZxGRxCE0WTdEMpuyeAiBu3R2-M2PqZ3sePh4kaJ15uteixBwtZkwi0l-DK9tP36sPcI1EUbMrfFh8p1njJu20ete7Uv3tdsT3T74vqNdjA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSOBLIZZY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSOBLIZZY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

