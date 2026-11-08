module 0xab2408c52e393c8aae3f8ce412a2c2c8f6b214ad1e24e8d664e6b2a8df4fb4::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::creator_authority::new_account(x"ef468a16dd5ff69a5d35d23ab8ea5540f1410ff34a2f2b8f3f0d573de9df3598")
        } else {
            0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::creator_authority::new_address(0x2::address::from_bytes(x"ef468a16dd5ff69a5d35d23ab8ea5540f1410ff34a2f2b8f3f0d573de9df3598"))
        };
        let (v1, v2) = 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::launch_ticket::new<MEME>(arg0, 9, 0x1::string::utf8(b"BCL"), 0x1::string::utf8(b"Blast Rehearsal BCL"), 0x1::string::utf8(b"Blast TEST_SUI rehearsal"), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::launch_ticket::LaunchTicket<MEME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::sealed_treasury_cap::SealedTreasuryCap<MEME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

