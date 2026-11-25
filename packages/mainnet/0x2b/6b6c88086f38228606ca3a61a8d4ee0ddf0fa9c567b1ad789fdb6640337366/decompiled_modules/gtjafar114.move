module 0x2b6b6c88086f38228606ca3a61a8d4ee0ddf0fa9c567b1ad789fdb6640337366::gtjafar114 {
    struct GTJAFAR114 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJAFAR114, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJAFAR114>(arg0, 9, 0x1::string::utf8(b"GTJAFAR114"), 0x1::string::utf8(b"Jafar"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/WD2XGyl9zc315VTuqSzxXJN6qB-xuJPY5f_w6oAOseLOzQjfL8Fzgkft31T0MiF1Lara6p-MD5sQj4m5MLbjzERPe2BSDkIEPzVItAbYgC2rLNZmkTPZYJIjFcyB6NeRQiyXa4O-dXs4baygr5EO3GqYwSN_pld4XTblCouvZqEhxvn40sqXZSdkQLLpTOwYu7J91ge9GpWkP1UAmWBIdmNTJszC1FRWj2tumaNKLYUm64Uqq-FFPhAsY8h27SLP4H3EyX8eS3ZWAYUNd7XFER_XY6tgS8tyCvUsqRP6YPzn4vegBtIpAVke9KyTP9re7TWTbHRyZPssaT9SKWoJsg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJAFAR114>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJAFAR114>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

