module 0x785f52d62b11f5d6120e87d5e814cbd18571b1cf6108f8d34138b76b8012e45a::gteastland {
    struct GTEASTLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEASTLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEASTLAND>(arg0, 9, 0x1::string::utf8(b"GTEASTLAND"), 0x1::string::utf8(b"Joshua Young"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/PH3zCPIbdoO8hSVqLhYeZr1ypYnfL2vKTpqVW9a5YR9FqOLFfcQ7oYitmTHRBSvSN6vdWr1UrT-2kASIMqSDR39HP87XXyGPTncxFexEsqTKj459fI9c2SEmTVObYpFXpm-mHx8eQMTy9AJxx4c2zWS7JsQxTe6P7dBPQy0fJn6BW2Nx79bllVKz3uv4WeEW8r-WcIMwgVykrssIkBlQZ75psLDE1Vf7TkRmU59C4yOv45WOtdrCnQGBJijyv0xa7rntQKn2fmVYpLshrUJoHNPs2leiLnQPYh1sKmaCvIQo1KCe6Cw8qMN4SKeyLHu6GOmaFP50Bp40QOqyvxezEQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEASTLAND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEASTLAND>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

