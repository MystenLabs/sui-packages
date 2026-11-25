module 0x4eadc0a86cb430501e03b56fab0a82d89a63912854b21e9b397122ee416c0156::gtjacob432 {
    struct GTJACOB432 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJACOB432, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJACOB432>(arg0, 9, 0x1::string::utf8(b"GTJACOB432"), 0x1::string::utf8(b"jacobigbrother"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/BD1KlsE6EcooR9dZFdtcaVgWGnJzdCZ949tY3ku04E9a5oLnn5af9_MPC4jyEPH9bbMrzOGFZfT_DsXfTna66rfiw7_k-McGA2vocaTtw_Ch18RNj-xRoYyFHCAi_CTms27DMPhGQ4B0wAhRHbUx3I0bhecSx_m7kTZ6mApxS_OhbW2FgoHt1Rb-0VXMKabfdOEgsVfzSP12sXj1Sc9KJa31ka5eUv4zfMeWxbVFeT2Bet7e-Wp4-Gc2jBXA-UpVDDRtsIx8qAjd5gMELi9zakxRJXcqKJysz0RizPvIovS3ocsRHg7AsU_xDaTlnHUXHjF0zMzt4YPB1lqflzQU7Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJACOB432>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJACOB432>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

