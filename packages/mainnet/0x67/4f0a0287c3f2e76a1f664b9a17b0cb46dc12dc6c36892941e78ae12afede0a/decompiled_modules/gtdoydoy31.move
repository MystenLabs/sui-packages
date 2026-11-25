module 0x674f0a0287c3f2e76a1f664b9a17b0cb46dc12dc6c36892941e78ae12afede0a::gtdoydoy31 {
    struct GTDOYDOY31 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDOYDOY31, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDOYDOY31>(arg0, 9, 0x1::string::utf8(b"GTDOYDOY31"), 0x1::string::utf8(b"DOY"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/cvRwsgSq1wb5hsRCncvQlrKfe6nARPmb3hkpea9T6SM6MSN7VHPKtNgHsQisRJiH7r9qeRmPkWo434bTOo-ZItRf61wTC1HCvln6oBPxpHGvdX2GhUdS02eI-4YbWuhJP_WPdrt6P84QHo3aup6xg68cz94ANKef6XjAQqU2MEWQeQG9NHhsXmXpx4e7z7pWWSHwsHywnHwMpG3kmWQVhGAzYAzwJ0cNchY8hgZ5cguWFF6V6eeloYzcFe_guNWBO0WoroWh9UvDtj9nBEYIOivDrBoxcpCh5KS2-aihgShaH0ZtWOhCC9Fe9kRDr9brnQBg_xbj0D6wb3-OrTFkHw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDOYDOY31>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDOYDOY31>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

