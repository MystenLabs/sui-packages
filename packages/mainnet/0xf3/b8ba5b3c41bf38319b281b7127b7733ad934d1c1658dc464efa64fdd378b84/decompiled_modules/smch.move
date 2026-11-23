module 0xf3b8ba5b3c41bf38319b281b7127b7733ad934d1c1658dc464efa64fdd378b84::smch {
    struct SMCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d618b2d2852355d163a0ba7221ab518f3136336fa33d3bc2813713afb9e33a21")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d618b2d2852355d163a0ba7221ab518f3136336fa33d3bc2813713afb9e33a21"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SMCH>(arg0, 9, 0x1::string::utf8(b"SMCH"), 0x1::string::utf8(b"SMCH"), 0x1::string::utf8(b"Musician best token"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/74469c7f3b0d728f5ef6adac0df162c382e3210a04e913c6e055992af853627d.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SMCH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SMCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

