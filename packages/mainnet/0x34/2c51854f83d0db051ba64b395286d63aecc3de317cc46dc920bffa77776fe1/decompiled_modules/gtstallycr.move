module 0x342c51854f83d0db051ba64b395286d63aecc3de317cc46dc920bffa77776fe1::gtstallycr {
    struct GTSTALLYCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTALLYCR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTALLYCR>(arg0, 9, 0x1::string::utf8(b"GTSTALLYCR"), 0x1::string::utf8(b"Just Stally"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/pwmgjARiSCIMLBK-60Y0RaOlrEp6OQ8mKW3OMreURAkz6gRxCuef5wAhi8hd-ToSs-IssF7XgWkfTGDP-_P0uaSN4gld7BDPnyt3lIS_nXQrqQf8Kiqb2-JR6oDA4giUHiZCq7OUen3UN90VJo2zo3tf-F4HQVR-v0ahsOnbPzaFXia-yw28fTzR-TU_DCUh_8Wqn4ViWlYKe6EMhREpzKEpgZbi19kXimS_wv1T99k7imQIUkoehY4qit0vYPTjTL8kKwo3o8XUBR1qatqAbnas4Cke-ua6RrWOGha3gi9w6k__1CT1f4UMdkKf6_XjOh-ts68aNjOWerrOFnkZug.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTALLYCR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTALLYCR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

