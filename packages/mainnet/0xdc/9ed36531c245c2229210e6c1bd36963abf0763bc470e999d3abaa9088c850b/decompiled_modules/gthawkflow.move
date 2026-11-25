module 0xdc9ed36531c245c2229210e6c1bd36963abf0763bc470e999d3abaa9088c850b::gthawkflow {
    struct GTHAWKFLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHAWKFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHAWKFLOW>(arg0, 9, 0x1::string::utf8(b"GTHAWKFLOW"), 0x1::string::utf8(b"hawkflowzen"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/dbBMI9PG2XekFLW0Svu24JHxy9Pm3FI3NzkqEDWTi1hjWEjUMEzZK7-jssykpQhNBO9u0XqNa0OVziig48MVOKu_e1e8z8ynPLbtquBJEudnnrJ1y7hER52TG1LZjBXT8SbUaR1KoPwjBvemzU0-6b5DiYdBU-Fxg-udnC3wQrYSVcD_sn1VJ3vkQrRkcYVxg5VRh3dBRe-gTvNXAsZdSOH6BQv8lM2ziTWEi27wcZ2FtZTxy6tgfn8mixRXmUFaW19T-09YBX316_vwQ91yhoW2vLSsKBHgg0GvRy1ch6E5DzxFVCuIsSTyP5Nr3137wKvmPhnHFFonJFoJE8OaWA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHAWKFLOW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHAWKFLOW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

