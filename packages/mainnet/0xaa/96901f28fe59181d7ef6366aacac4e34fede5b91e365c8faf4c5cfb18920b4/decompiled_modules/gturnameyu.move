module 0xaa96901f28fe59181d7ef6366aacac4e34fede5b91e365c8faf4c5cfb18920b4::gturnameyu {
    struct GTURNAMEYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTURNAMEYU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTURNAMEYU>(arg0, 9, 0x1::string::utf8(b"GTURNAMEYU"), 0x1::string::utf8(b"Yueqt"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/fHPLatbQ2FFl_jrH6iTiZhxOBIRYGriivao1lBmRqJt_oBuC-xdPzg3X1GM1JO9vBul7oMTzMP6YZ8lQ2qtt7i4VZLs-DYc_8NHgMBE4dYdv800VgV34MvnNv2tSEGmbmpuxIQFaGFqPNu7qs_ZVCJolwtHKIz8XnkCr2yPlOcZcUOUJ7ktRb6PZbx9HrKNw7h5xcjXkswsBWzlxHDQOQ0pQJTWiW0pkMzDErW3YjTmZ34a_W7vs3ghb-VE3yDc8v2bedX1Mf4xkJae5KVF1r-nljfUE5oO3rrYtG29gnM3lt_FK3sZuB1tDMHF28PoilkbOyhXCLXalSJ0QyWoOyg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTURNAMEYU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTURNAMEYU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

