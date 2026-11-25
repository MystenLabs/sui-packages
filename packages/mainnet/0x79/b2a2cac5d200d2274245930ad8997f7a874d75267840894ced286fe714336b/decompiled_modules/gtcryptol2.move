module 0x79b2a2cac5d200d2274245930ad8997f7a874d75267840894ced286fe714336b::gtcryptol2 {
    struct GTCRYPTOL2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCRYPTOL2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCRYPTOL2>(arg0, 9, 0x1::string::utf8(b"GTCRYPTOL2"), 0x1::string::utf8(b"Cryptology"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/iNEpOUZsqGcE2PLvug0pWHScZm_RV3zYuzvvKmxIgOysUIJiwT5slcXtoVRQkH8D7Q4wWA-ugZy87N4mMvH2QJayaCl5DwkakdWtQ1UlZb-OzsH-ZnSD9YueH7dfFgUn2rUPYlEIa20JBfhkbAv1lgARWwxAo-lKzTg75ZIojn_6uAUnjUzrV5azNnCz87yNSWHcHswuFjIAqXGauFhUhB4hHuRQgTbWOXOHAMtEiEOgAcwlENzkKxGf6wuNw1k7cUa2ChZqUojuVSEklvxpMUQE2Ln4mdfu5cMehBYykmQOekRgMZxj9uOfoZWq_h0KO77Ew-dFGH9k3CUOnsvTIA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCRYPTOL2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCRYPTOL2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

