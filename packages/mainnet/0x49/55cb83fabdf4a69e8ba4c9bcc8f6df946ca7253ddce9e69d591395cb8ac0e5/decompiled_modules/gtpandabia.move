module 0x4955cb83fabdf4a69e8ba4c9bcc8f6df946ca7253ddce9e69d591395cb8ac0e5::gtpandabia {
    struct GTPANDABIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPANDABIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPANDABIA>(arg0, 9, 0x1::string::utf8(b"GTPANDABIA"), 0x1::string::utf8(b"PANDABlAOCEO"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/OOd4kgNJ1fGfNNe74VkZh6HHbW0-JbEEJ8nKscWKdQvtSLDnLFxfCJOUNn6f-ztSzgTgsNbnRDkwnolKYzkvopQ6RlqflHMtt6LSt1Ea3HiuiV-vZUPrq7lWRy-iiHZJ5nPF4i0EHK6rEzdNnFuXz3A7picC5CSiLgF2Q9hmbXr2DmQJkgefh_9J3z92JOdPXDHxgHIKwJgjbDcObnPdb0zmJts3RThYaSHS5aJrAPJR7Zror7ac7RMrz-cNQ8nTYPoWhAfBWR39tf6---VaisQx-EfuTDUWgfsZ-Ik6NX8JmUgRLUNuHPfSGC9rIJofTUzQa25H9jQNBo4VVQ-7gQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPANDABIA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPANDABIA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

