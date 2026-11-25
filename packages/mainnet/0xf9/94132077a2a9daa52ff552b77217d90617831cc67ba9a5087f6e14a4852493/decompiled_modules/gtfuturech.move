module 0xf994132077a2a9daa52ff552b77217d90617831cc67ba9a5087f6e14a4852493::gtfuturech {
    struct GTFUTURECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFUTURECH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFUTURECH>(arg0, 9, 0x1::string::utf8(b"GTFUTURECH"), 0x1::string::utf8(b"Md Tarek Hasan"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/HJwVMn_9flajjeLPZ0hugWmlc-1kd8zKIlY0f2koK9B9jLl6juir84EY5f5m8SW1bimWnbqmUhSwxckPB8Oqyt8aFHGYYv1bnzIRukjJGv8-IUWOQNvtAC6NOVKm_5zP10vP8hxH3-DKV0714bpi9nkGlnRxIn1Ixo8RUZBr7fc5UMaIYAllypWRI0e9Kmma_mEmwaXckz9Y6nJESEtOWmPJVK_Gj52XcR9gZEFFQsTO4NxupP5XWI7r97XdbmFF2tfoimWoOel-aEG0oeUcGZTZmILT-L8e8vxbMQogHhYvLvZ_-v_52Dj2HDSRK8d-2kQqzXJP-xXRi4PlrjUcvA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFUTURECH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFUTURECH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

