module 0xd791683a29baa758688e0ff190d4f4c949b22a4aefd797f84b5522d378d97e6d::gtsuiper0x {
    struct GTSUIPER0X has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSUIPER0X, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSUIPER0X>(arg0, 9, 0x1::string::utf8(b"GTSUIPER0X"), 0x1::string::utf8(b"Ox21SUIPER DMC"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/hP6MDOd95qkKWXylmMYtXU2Hd2jCTHM11CH342hP6dv736G-_t6gLyR-tdElxhxvGWux_lqHQiHqKmlsQyPo3eRTypTzlB4rby0b35iTknMF96N0iPiq_85dwFBlIp9EJ783yNkpBiEgwDwm0FqY7oOX8KUBtJXHXtaKFpAgAjl9NUr9Ag1i4IMkuOmEZKG3Ixkt5BdK_XVCMwcnSLiycixi7xPMIZ63bogKlnlkQtqej7Bto8cHepEHH8yGgATWnjRV44lNncpFugG3Cq8tb3RDbLn3hwdr7jzZcSGfVUWMvFlgHvtuGW2gSrnhPc3SJgANBB-KxHO0kaoUqmwrhg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSUIPER0X>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSUIPER0X>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

