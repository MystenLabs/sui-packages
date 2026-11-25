module 0xd060e2de0ce2f56837ce5f645089659b8cd6c6141b37aecbf4ec694b6cd24c1a::gtse7endig {
    struct GTSE7ENDIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSE7ENDIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSE7ENDIG>(arg0, 9, 0x1::string::utf8(b"GTSE7ENDIG"), 0x1::string::utf8(b"Moon Boy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/bJGuLNOEQSdy2_jKn3IzB92silBlhQFrpLUmSbzY5D0ImGj69SpkCH6o7R9JeXOQ6Z1u_4FubMtgr6Z-QPvGdDsMITlHJp1elkGeBRmn-wpjSgdzclG-4znFDh-lt2CKP9sNo2l-Z7SuIAudpRyEfaydy41hz5jjpuLDyyGwhf1oLql5Dp_eiSZwHVFGiX26QJ-Z8VlGxvN4jqFXp3QGdeOKZp8ttY-Ihh05LXAeb37pT5FczYenXHm6rY9x_9G9e-L6MVtkvjgXYqd7njcwTL3QZFByDPQ8DVPZUJt2u1iOfVR90Na-vZO2reVX7KFo3MH-azZ3rD79f9K9dUwY9w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSE7ENDIG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSE7ENDIG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

