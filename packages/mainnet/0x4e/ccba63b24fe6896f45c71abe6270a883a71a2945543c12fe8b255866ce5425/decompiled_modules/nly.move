module 0x4eccba63b24fe6896f45c71abe6270a883a71a2945543c12fe8b255866ce5425::nly {
    struct NLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<NLY>(arg0, 447581274884313711, b"Nelly", b"NLY", b"Nelly, born Cornell Iral Haynes Jr. on November 2, 1974, in Austin, Texas, is an American rapper, singer, and entrepreneur. He gained prominence in the early 2000s with hits like \"Hot in Herre,\" \"Dilemma\" featuring Kelly Rowland, and \"Ride wit Me.\" His debut album, Country Grammar (2000), was a commercial success, followed by Nellyville (2002), which solidified his status in the music industry.", b"https://images.hop.ag/ipfs/QmeziZBRxt2nsotRS2gBZM2EP52GQU4jKj6H9S9pTCMiM6", 0x1::string::utf8(b"https://x.com/404nelly"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/Nellysui"), arg1);
    }

    // decompiled from Move bytecode v6
}

