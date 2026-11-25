module 0x8d72bd787ef7ed56c4109be94d861b86255d69e420f934479455a9227dafa1ab::gtslayerop {
    struct GTSLAYEROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSLAYEROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSLAYEROP>(arg0, 9, 0x1::string::utf8(b"GTSLAYEROP"), 0x1::string::utf8(b"Slayer OPU"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/W0kWS6eNTnxpocAF_A2v0KOLqQk_KR55tc2Uvt8T6OBZSa2mr_Vyz9q49pHOdsD3mKEasMzqcme-teBm-KjOljHtlRlmGVpZxt8WU9CvpkR5Bu-4wzhJMMzwiRpuZM59VpWG-o7aS-qWhAHAmas6eg_TUU8VygGY_0YyG7i2cCLYFND7aVBO17Oclcq0WQ8MvZDNrKJAdIZzOxMyCgwXg33z-Op21NsSxmMwPmrv2pdZePXRvFQFV6Vitim3cagRk9pUIiNPf-29HPaijSpX08eQ__s_nkOsH8V70MvPxndE08qILi_TJvPFVgPMkr6VkV_esOweEAX97T12ckre4A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSLAYEROP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSLAYEROP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

