module 0x53602c68b27bcd469974df62b6e7be47fc3f343898d1a2cd37ae033c63c22422::gtvyzcm {
    struct GTVYZCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVYZCM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVYZCM>(arg0, 9, 0x1::string::utf8(b"GTVYZCM"), 0x1::string::utf8(b"Stravia"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/lOjkt13HB0P89uQc2RqXBH-IVoYwQH9QLG4Ub16DvxUJzOtZTdsSCLXh5aStdMByWjdhRMzRUs5Q0Hodwmxh4wchzyAgbL01hNmw6xe4FpSIAu5S_wxt87tJT4mgGn4H1W8_omWriYgKXDQR-mvmqkVOqJnuQp0Ab3uVhgKtI3StR6NpdsLgrBbKNDYW3RjPvKyFQbROqBs5_A97s-p-6vhVahxvQ4_S6lCQytiG1GhhimEgCxFOxVMvLInLYkNapPXnH2eqKQBvpe8CQlwDveH4G-K98dnDIOBM-5eT3PqDVFoYFPZvaoH3rOURTa4SmY0nKrHsUEItVvdN87JxAQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVYZCM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVYZCM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

