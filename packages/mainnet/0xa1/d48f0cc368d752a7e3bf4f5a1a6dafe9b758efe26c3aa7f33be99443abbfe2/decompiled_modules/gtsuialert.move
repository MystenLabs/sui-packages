module 0xa1d48f0cc368d752a7e3bf4f5a1a6dafe9b758efe26c3aa7f33be99443abbfe2::gtsuialert {
    struct GTSUIALERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSUIALERT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSUIALERT>(arg0, 9, 0x1::string::utf8(b"GTSUIALERT"), 0x1::string::utf8(b"Sui Alerts"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/E7RMM_8qEgV3LN66hLpLI_1IUCMj0bx397w0nTAEZ4liRROTPRjdalod9BXPJy8D5njWLZnHB2ZuQONW-34bst0GDoxBQ6kknwYwImI0U8FJNRAsQC78I8HyxFzdskGLVIeawRA6TFmqL0GLAvFH6ophQm-i9VbHXB1aL9A1nq7gtmp25t5Q0VAEdy61nb_yFY5bKBBV17F0JJXv9i5UmV0881iu0WqJBmdgQGytTrjfh7GQmAaC1zs7lSNbsq6KHwiwOwnp0AtzyzoQs0U24a_jeVEHcq0geWjrKsFzPmBsn87eGtEpQanh27FnARsBtfyIa9wgRgmvoOOvpSKApw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSUIALERT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSUIALERT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

