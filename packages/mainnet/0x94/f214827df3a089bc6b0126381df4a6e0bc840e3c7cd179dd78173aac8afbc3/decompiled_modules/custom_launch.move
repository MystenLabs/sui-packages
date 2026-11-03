module 0x94f214827df3a089bc6b0126381df4a6e0bc840e3c7cd179dd78173aac8afbc3::custom_launch {
    struct CUSTOM_LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSTOM_LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_account(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600")
        } else {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_address(0x2::address::from_bytes(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600"))
        };
        0x2::transfer::public_transfer<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::LaunchTicket<CUSTOM_LAUNCH>>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::new<CUSTOM_LAUNCH>(arg0, 9, 0x1::string::utf8(b"ELIG"), 0x1::string::utf8(b"Noncanonical SDK90 launch ticket"), 0x1::string::utf8(b"Worthless publication regression"), 0x1::string::utf8(b""), v0, true, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

