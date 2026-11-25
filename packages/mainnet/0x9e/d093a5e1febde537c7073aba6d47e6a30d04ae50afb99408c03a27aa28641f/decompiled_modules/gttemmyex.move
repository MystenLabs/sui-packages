module 0x9ed093a5e1febde537c7073aba6d47e6a30d04ae50afb99408c03a27aa28641f::gttemmyex {
    struct GTTEMMYEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTEMMYEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTEMMYEX>(arg0, 9, 0x1::string::utf8(b"GTTEMMYEX"), 0x1::string::utf8(b"Temmy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/eUDbt2T62rFKQyN7Pj14JvMWavCKcn4n3ML_HmQ_MQ5RH5MMND7xGSRR4ARa8iD_ePk9R09dXOMevSIeGf3PywZsIkU-hKmuopRkb2REIO1PscgQMwAFLsuAdAdtvDQTqhCxRf_qio1Ob3pba_vLVuOj_8T7Ql-XilGAAcB5asw2njXKhZBIV9O8xbHI8fpv9KLmafIGbxbYkLoVhtUqsdxspx4E2kzoesotvPlSypoRh7NARIQ0HdzoskLjmA9af7sG6e1X1W69uJxZDfsJ08_vZn7VRp8qz7Os4GP0eANQwlWRI5ttr9tM_o2O-yZOJ2s1GB42Zg26xOnP_J9w4Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTEMMYEX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTEMMYEX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

