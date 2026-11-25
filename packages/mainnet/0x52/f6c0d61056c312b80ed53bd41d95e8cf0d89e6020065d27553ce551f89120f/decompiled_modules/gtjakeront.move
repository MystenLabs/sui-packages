module 0x52f6c0d61056c312b80ed53bd41d95e8cf0d89e6020065d27553ce551f89120f::gtjakeront {
    struct GTJAKERONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJAKERONT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJAKERONT>(arg0, 9, 0x1::string::utf8(b"GTJAKERONT"), 0x1::string::utf8(b"Jakeronthia"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/nmQkRJrYBW-tYKbXfwyYCtwc6te4-YmNOQfafAh0BzSGOLf2pt5KnO6PQyXo2wEzfS7hUotOiF_1qFHgkxKv42XdTy8YcYbEh-8cwe8PU3VSBVqaXxMndsqJ-uGxn1U9tNxzHoUhEK5xct2VbaX09Z65SOhQrZZgBEntC7qxRf_yj8B973zcEwt0ryiXOITgVY9Hbrz-L6uz6OowZSYAPOoaJTdfccrPArnn9jPc-zFTifyxOjQxe4pN57guiNTriRIIfty_DV421V1ZrCYDuhTBEhGv8OYAOAm1nbC82QSRsdPxpul3RJfDll0M8LITXXq2VklqoN1PR9drwShUwg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJAKERONT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJAKERONT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

