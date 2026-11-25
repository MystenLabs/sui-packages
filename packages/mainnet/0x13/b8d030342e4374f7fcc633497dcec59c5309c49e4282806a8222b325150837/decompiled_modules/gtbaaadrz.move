module 0x13b8d030342e4374f7fcc633497dcec59c5309c49e4282806a8222b325150837::gtbaaadrz {
    struct GTBAAADRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBAAADRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBAAADRZ>(arg0, 9, 0x1::string::utf8(b"GTBAAADRZ"), 0x1::string::utf8(b"Baaaadr"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/T1kIwga9039aIvXtjMj6eFLofxVlrdOVtTy_uPDtuxThmfZlaMQ2zsz5hfW3TES_xvdsW2-MImys4kXR_F8vLfCxUZUOK7SNZywGEexr2f3UI_LWUG-szKNUBdzkS24GR-xvVMQ5qpHDdvIvGYMzgZ8FiSv7IViAeR6Mhh87SnThT5c_Y2FCClf2Khi6G_qtCTeo2yUO3aZHFO1gAQUJ3Q5jErq78qnqETM4Jgyg2tTiLtOsEZUINpfCrWzRkP7VkjjV5jx8sC2oif8tn0THQaH2gdS_ld6g2A404KqiCVzS8B4SRSlL_vWw6UDweP6Jzunz4qadZb5sNO86jb8zJQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBAAADRZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBAAADRZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

