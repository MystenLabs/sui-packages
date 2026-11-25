module 0x2cf48d35e9ad9fa9276235a79e3753c4f9e788802267ffe4b3a0219248dff33b::gtobi0001 {
    struct GTOBI0001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOBI0001, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOBI0001>(arg0, 9, 0x1::string::utf8(b"GTOBI0001"), 0x1::string::utf8(b"Obi_0001"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/KGtNYoNz5CXHdd76SB--Qw6aQbRF1-iduaFYRNhLCU5R4e8Gb4hhdS-ukj9wnrt1w0xOjd7l6do2ZTi3ad5A-73_A6BRY3pUTg7LRQR-rNCPyHIf_DjO4da6AespcQmQuT4cP4qCRAgZjTWa1YITu65dd_acD0OwCQ9BRJgRE-T07AKudng6WkwSVCMNIHZ4EOE7GNZ6Ro3Df2lZelQyPhFbQERQFfiW6e3aZdoosTfPheCptlBmcrtm4AnnJz-qBOozuUBp74upt9F6mj2yJ2JFuuD4Kg5akPLzXtN87Z1o2A8sAjfSDG5BkZnOunGNUYoOmtc2kJvOXFN_niTjZg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOBI0001>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOBI0001>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

