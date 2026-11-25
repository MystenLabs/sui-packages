module 0x63c8f0a5561cbab0762a86d77354cf8cbe02aac163576f9705b642d6a7d40909::gtsceat {
    struct GTSCEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSCEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSCEAT>(arg0, 9, 0x1::string::utf8(b"GTSCEAT"), 0x1::string::utf8(b"sceat.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/BNnHzKW86Ui33qg_DVDsHeBB8sGCUMLCMOkfHZLdlQyiTQ7q8NhM8vRNnhTlwC5APeGd5QDiV4oQkYJK7W25h1LxeeRIKBkn3UNxhctpOmuIVP16wsIB4l00QbB-wKMGwgFwjnaXBsDPTwtCh0QuWUXnjjjeWVQ0f8BwGjHt2GTPAgR-dQCiRYVWODP6RP1dW6ODhPJhbPCwy1Bgs7qlJpJvWlysj5rg4j7T6qashbDYOMN2Vme-BkoE5BF-UATXFOk7XxDE6cVsfbyF0081sowHoEx6lKMZSovjC25so7HqgtZ2nEv-XjnG8b5ExVCipdUnZBIclIi4xR7q9dBG-A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSCEAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSCEAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

