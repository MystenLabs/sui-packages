module 0x478b2f5646867f7f4f332c976d0cdcb180c206cbab1a2180ced411dcdf73c74e::gtfreshfri {
    struct GTFRESHFRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFRESHFRI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFRESHFRI>(arg0, 9, 0x1::string::utf8(b"GTFRESHFRI"), 0x1::string::utf8(b"FrESh FrIEs"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/lARB6ZjVlLVMwd5IhWN7fMDmbRvtB2Is5sxDFFVnw9ttDSvJw94h4RCdaMeffujHkbGq8jC06bxuDxHfq2J-wQOe0aR6-qT9Xz-AmiZAsZAL2E-UtY7a8vkc0s71Wr62f71Br5YCT61qIYwLEXgckI17McrWSMEYwCekPzpZm-e5IuSluU4nPOvay41dqUstxY16euDjANZGcYcSHpr7d36a3K0tAvLMLFLElF1o3acCT95wtRsROpYZwJ6S-IrzPSc1JEu5z8dg5rYocKqpj1UzPSXHjbG5Yfo0tk6ob4zCLROTsyui8QdAqQ0djy8sjkOHZe_pzhaSAlJ6ioby5Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFRESHFRI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFRESHFRI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

