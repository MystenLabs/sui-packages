module 0x9b1530a45efbf4a23065a7b49629ef3bc45329e30b5438952c07193e11d4f960::gtnikkon02 {
    struct GTNIKKON02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNIKKON02, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNIKKON02>(arg0, 9, 0x1::string::utf8(b"GTNIKKON02"), 0x1::string::utf8(b"Nikkon"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/gsOCmSFeHmfIdJqkS_d5D87kWXHbIgwsUxpiyJAGE8PhGu9At57p-OxMu05JfWc62augQ-9XxkPI9B4ZnmhR-1648mt6w7u_T9q3nQ7fsPCfiCMC2ok5Lw08cyPkvGmYb7klwmuiYH6d3nHjSe2zux22Ghj4pTb80z7WfQpOFHLLpAZccHGNGn44SjUzhIhAq31SyuDljVPcJCK70A6SZl5S51QaPn_7EhLxPlIRnQEtsXZ7ObzslLP1exWpFYBM0OSoOuq6KFy4wOJoQmP4NBIkLWlCCKzt7pe8wRJCiuaCOpfCrmWJcfNitSs4ODqvHq_Q4ZnR2jhcMZN0kV25Gg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNIKKON02>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNIKKON02>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

