module 0x6dc29381d3a1ab392666eedbe5e27a9e6ee00e8839158e4371ec2bca37623bfb::meatthezoon {
    struct MEATTHEZOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEATTHEZOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEATTHEZOON>(arg0, 6, b"Meatthezoon", b"Shaba", b"In 2005, Jawed Karim, the founder of YouTube, filmed the first YouTube video \"Me at the zoon\" at the San Diego Zoo. According to research, the elephant in the video is called Shaba, who is 44 years old this year! There is only this one video on his YouTube account, which has been played 330 million times, and the background of Jawed YouTube is also Shaba! https://x.com/historyinmemes/status/172402682363659882", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdjn_Pe_Zd_NDJQS_3r5i_P26r_YC_6h_Zr7_UW_6_X9jd_A_Mc8_T2_Tt_Qn_6448ea63d9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEATTHEZOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEATTHEZOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

