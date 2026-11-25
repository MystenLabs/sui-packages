module 0xd1a36a12c7d60a04a526ab70606ade903e6848f323c185dd2cfbd44d5d7cd7b6::gtcaaaaraa {
    struct GTCAAAARAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCAAAARAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCAAAARAA>(arg0, 9, 0x1::string::utf8(b"GTCAAAARAA"), 0x1::string::utf8(b"Cara"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Xc7jj1v-KBQoQpd0Qd53uxmBxIyfMGs0rwnLSSTGL6dCVuAcjP9wKwz5mlfIvfBHxY7eIaH1czs6JvWanJWmnXOjAiN3rAwYPhCdEdijfmc_b6YerWgwUtIycaeU_u6NQyI7Xxop6VMbgppjBlu1DQ-8Md2w1-30T05o6TrVAWtOayfRJswep0i33trdGcYG9vzneMet6LY30wibbgb-XRkWa47qVlPtzoqiqmKvGgJXI4HwQLL5WfKWmR5XCySh9WtXd3VvwT1urkARfUB9jeXQPZDBz--DI0vCylyWRYByvIYgbqAleTQgACNkHFXvr5p1qzTM4kDmUWphS_SQ6w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCAAAARAA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCAAAARAA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

