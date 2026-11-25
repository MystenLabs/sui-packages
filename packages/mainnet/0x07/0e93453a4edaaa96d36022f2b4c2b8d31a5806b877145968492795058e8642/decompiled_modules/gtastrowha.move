module 0x70e93453a4edaaa96d36022f2b4c2b8d31a5806b877145968492795058e8642::gtastrowha {
    struct GTASTROWHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTASTROWHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTASTROWHA>(arg0, 9, 0x1::string::utf8(b"GTASTROWHA"), 0x1::string::utf8(b"Astro Whale"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/USQHU-gIt2pJrJW4WxmdYI7UBMZmZq6hbrjy6vV33scyqriVdjwdW5vZ6eV7QVUO8UxG5yQ9eEXBN0K_O2v2caXW92DmskzJDAVgOB1tefgqSDKyow6yEFg8rxzDZYTecsFAcMCYP75qtN9zVPhrVpKWDYEphYhCcxqWgse6TsyFhw24gnnDfIfBshouhXhVCeNGwMW6UKutekL3dxec24FIzJt25Cgv_NPW3JdEGggaC5Zsq-Mx7Txjzv2L6kixp_LEDTakh8ZJ7p34H0Y6wMibLXEkVOWd-TPgMobARoDUoICzXFEVu5mzUlqcJyfGAQft6ly_RCiUUrKPz0i_OA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTASTROWHA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTASTROWHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

