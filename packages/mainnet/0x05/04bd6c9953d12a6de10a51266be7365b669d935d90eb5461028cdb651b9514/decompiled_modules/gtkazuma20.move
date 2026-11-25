module 0x504bd6c9953d12a6de10a51266be7365b669d935d90eb5461028cdb651b9514::gtkazuma20 {
    struct GTKAZUMA20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKAZUMA20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKAZUMA20>(arg0, 9, 0x1::string::utf8(b"GTKAZUMA20"), 0x1::string::utf8(b"Kazuma"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/OjL7u6_7PBT2HDizZxaMEJabQxduNhdPjKPnEaq3lrwasvlTmtCJesaKxAco6KRgZHbA2DnRb_v7CJcaNz3HdYuDZZl8R0ejraoVNHcsgS2V-PtDcs73mO2EZj0s-ZoNuGAIRLs0XQ5mVyFvu_TfvQxYfwgOP4qFsYCPdt6-uZWXUqYWaWUTl01ASRT3VHM7YEw0rHlZjcSw_9cSXkkndth6eJexro8RdM8BW4NT9yhfX_lJCQvalGKUHmY1KbkzYiZ9O5z3T1Xepm06zooB7EJ6MK_iAkVHtCOgGDm8QFkxPX4Nuly-iPzE8ohL32toCOcp-7zDmVw7muib1r-MTA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKAZUMA20>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKAZUMA20>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

