module 0x7fa0d03aebceef172b77e13971be1a883f2e0c0a26e37994778b338c0589079::gtletswind {
    struct GTLETSWIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLETSWIND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLETSWIND>(arg0, 9, 0x1::string::utf8(b"GTLETSWIND"), 0x1::string::utf8(b"Winning Arc"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/oR9uBZZMMSMByMvLL02AKyuSKwmgszZql84SEW0Beff_cb-R2WAViVWQVAxGZHaeVnRLxGeVZFXpU7if93T7-A7vP9hAnTJrmWq7b4y6ojhWNw_2rVEdGQWsr_EbzkkckeMX7TQ-nDUIRtbUtQbmJ3GJ4TCn4BMUYvkpElcTrg-1enMi9HB82nsxJUgIVkPHRdXnrIfx3wX09DdenaCJgodLqcd1QtdB3feGcoc7WR5Q-0IgtOyg_GSAEKegGI3yBHH6FwOphhtX6hnD-cU4gUXQnOwbm-3MGcdHBHt5NEkdqqMyPdJ_gAmjLQsrCZSJY9s6ckn123glM_9dZhAJ7Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLETSWIND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLETSWIND>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

