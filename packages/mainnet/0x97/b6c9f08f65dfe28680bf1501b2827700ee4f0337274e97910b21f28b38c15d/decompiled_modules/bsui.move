module 0x97b6c9f08f65dfe28680bf1501b2827700ee4f0337274e97910b21f28b38c15d::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e0d6f278cf63f1acf11791f33e823dee5ac76cb2cff7ec58b0e4ce6db4ae7aa1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e0d6f278cf63f1acf11791f33e823dee5ac76cb2cff7ec58b0e4ce6db4ae7aa1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BSUI>(arg0, 9, 0x1::string::utf8(b"BSUI"), 0x1::string::utf8(b"Bitcoin Sui"), 0x1::string::utf8(x"5768617420696620426974636f696e207761736ee2809974206a75737420612073746f7265206f662076616c756520e280942062757420616c736f20796f7572206b657920746f20446546693f0a0a4254436669203d20426974636f696e2d706f776572656420446546692e0a0a416e642053756920697320656d657267696e6720617320746865206265737420706c61636520746f206275696c642069742e0a0a48657265e28099732077687920425443206e656564732042544366692c20616e642077687920746865206e6578742077617665206f66204254432044654669206973206265696e67206275696c74206f6e20537569"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/16669be89725ae900d778dae5157cba05d2e3216bbfd81b9e8770c822bd087ba.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

