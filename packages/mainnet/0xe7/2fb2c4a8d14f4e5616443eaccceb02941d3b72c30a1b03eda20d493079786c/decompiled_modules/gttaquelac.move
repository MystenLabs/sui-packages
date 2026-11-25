module 0xe72fb2c4a8d14f4e5616443eaccceb02941d3b72c30a1b03eda20d493079786c::gttaquelac {
    struct GTTAQUELAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTAQUELAC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTAQUELAC>(arg0, 9, 0x1::string::utf8(b"GTTAQUELAC"), 0x1::string::utf8(b"taquelaci"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Rtrk_8z73mPqQdvk-JR7KPyn5OhQH0-4j172Et2sW766p41ll1_FZDGW-4a_R3QbjNg9IG7Jfd0la6DJlbEmeseAtb8aGBROQFLyfF7yTA0H8j98pFQ6OZ2sJ6b-N5PaOhi0N3ZhRj3yAQPprJydprQkmHXGRbPwBU6H98Ye_rmbitzA3oRaVv4eYbRsGhyuczxLH7Q-sfaQjJ19Dry3vm_JuoTRFQoC2lHETQ5M2F9sQ9VEn07D1JxJZzXiTdrjitH_VkpdvozOiWNbv3BeN1OF1IkqXVRkhc30Oxo7ukMCp1a_WfNd-TqKOro0vuFwzQxkzqAereAuv_wgwJHHHw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTAQUELAC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTAQUELAC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

