module 0xfdb554cbc4aafe8b47a7f368f844dec2446b494895c29de4882cf114478715a1::gtmrrayhan {
    struct GTMRRAYHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMRRAYHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMRRAYHAN>(arg0, 9, 0x1::string::utf8(b"GTMRRAYHAN"), 0x1::string::utf8(b"MD RAYHAN"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/rz_xxUbF54lgyUrdt977G3NIbnxYLkgWpBZ9C_ffh2OUCCtZ_8f7GkAM9209VZ_cXyjCdx-w1WyiyNipgchYjvjYsDu11brfPsZ0UMa_9t7tYQA4Zy6oCfihog0rm_Z3861qQWFN4HSVUJPdjRsuA1Qo3MnKS97aIQaevAFXLP8tFPoMAmFuzrfIxE6YLebWtFbz8wJkYvpUMm9L5ziaIBxHPH6lVgXCUbT6aQz6UEho_vofRF3Xb8w0rkuWs4MoQ6jV9AzdeIpHS69Jw7Y-uQi9oDYjwU7t8ElnYIXVyxqGYsLKcSRg5r_Q5dj_py1k9sf8D6HRPPGNoyxzwXSxJg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMRRAYHAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMRRAYHAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

