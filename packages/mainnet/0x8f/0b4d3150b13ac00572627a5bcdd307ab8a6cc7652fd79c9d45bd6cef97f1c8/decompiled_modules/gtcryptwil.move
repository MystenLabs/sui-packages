module 0x8f0b4d3150b13ac00572627a5bcdd307ab8a6cc7652fd79c9d45bd6cef97f1c8::gtcryptwil {
    struct GTCRYPTWIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCRYPTWIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCRYPTWIL>(arg0, 9, 0x1::string::utf8(b"GTCRYPTWIL"), 0x1::string::utf8(b"Crypt_willie"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Ws8CMZWaZpj2UDHCewyNU1p5ogaYM1svY9vqF6hLG7jAKrYnnSCMT0uKfGTJ4HeWrE-h-WKrp3J8mJCG_fXNbDOvTm26JkUlHYEJzCV8tdioSgskWIWxvZAoYzAE6LIDXsTUn97Nhc10G8mTeRYAvj75QrfBD7cQBNrs6HNGzBU4MvvkT6ic5Ft-5_e-CqanzHfjBnui388e_D6doAFBasz9x7rpoS0EjEZk45InqP-YcFvUaHM6-3R6A-A0gbnt_StWmO3yKkVCqWMeTX94bItU0vo3M6RDQumY6nC62EpBSl9HnafykbOVEI2prSYcn7F1__cYCkVKhwc85punEw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCRYPTWIL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCRYPTWIL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

