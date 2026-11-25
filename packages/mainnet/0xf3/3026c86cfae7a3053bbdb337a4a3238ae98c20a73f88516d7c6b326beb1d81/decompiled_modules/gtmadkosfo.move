module 0xf33026c86cfae7a3053bbdb337a4a3238ae98c20a73f88516d7c6b326beb1d81::gtmadkosfo {
    struct GTMADKOSFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMADKOSFO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMADKOSFO>(arg0, 9, 0x1::string::utf8(b"GTMADKOSFO"), 0x1::string::utf8(b"Konstantine Smith"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/vdbnzkLKyjbBW6hFyjL330D8liX0AoArhC5UtanH_-5DAyh_l5bgS2_hhIJ1qDX8MJOpn3RetxVYKvVGNTwFl4vA2TkMxzKwySUW9SAb-aaEHiqVhlLE8Vsv1nt12p_Z9J-TeryPK86IyJMohDSD_47yngAOA4PIOBxnq0n1dvfXI7g_cAbM8-VomCKjsnSxjUKCfw9q9BpeTy_RV2JTaQ_d5i04lklA7tW-nfHEru7uUWcsy-KWYgMcoCnYUVe7YIBc_CuSOwnAEWIqjPb963vKVtqnT7-5w8_6WZ6jituPghV-JgF0z2AbSuAKkeSxffPeLR6oJqfbAI7Fxdwghg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMADKOSFO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMADKOSFO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

