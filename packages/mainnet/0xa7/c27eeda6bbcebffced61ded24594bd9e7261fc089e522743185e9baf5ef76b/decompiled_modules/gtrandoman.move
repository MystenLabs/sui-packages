module 0xa7c27eeda6bbcebffced61ded24594bd9e7261fc089e522743185e9baf5ef76b::gtrandoman {
    struct GTRANDOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRANDOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRANDOMAN>(arg0, 9, 0x1::string::utf8(b"GTRANDOMAN"), 0x1::string::utf8(b"Neggs"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/j7tRcfLHEaENWkn9VZg9MusaFHM9Fy12fA31BFz_YUhJIO3ZjwmHeJBaDA4k9cQ4KIH3HmKkLU2P20JNxgZVAul5poxxYCZSX4gSA3cC1ZcMpdWUOjr4z3H_vcVdE0v9XZjWEjpCnG-eUSoFUElXfOc1V8zv1jbb9ayThhezjYOzLJo5xBp7bMLc1bl9KpBON-gw5esp6L9hf50mJwk4kOtqYP3ZrviBG-WjhCb-edSyyN8iDs_IUQwpzsX4Lgr7BtmGLgW1GL56a0oiQA5JBc7sESu50bJShy0YkLOS9RbiE2uFCz02vmAebK-EfHOrCGuw1J0tW7XsJSYwxZBU_g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRANDOMAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRANDOMAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

