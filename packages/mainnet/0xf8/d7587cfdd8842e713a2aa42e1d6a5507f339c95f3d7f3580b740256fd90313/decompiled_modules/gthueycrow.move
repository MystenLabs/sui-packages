module 0xf8d7587cfdd8842e713a2aa42e1d6a5507f339c95f3d7f3580b740256fd90313::gthueycrow {
    struct GTHUEYCROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHUEYCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHUEYCROW>(arg0, 9, 0x1::string::utf8(b"GTHUEYCROW"), 0x1::string::utf8(b"LEGEND SHIT!!"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Uf7FSXTzwObT2hy9Tz1zr6yiIg0lF-Qracn4vBKPunamCdPc2mgAFTvALGImgLuuXGYykHKKE9bLXgm-1y7BLEEtyl3mTfpjqtK_mz5ZpVqgkoGXTY8Oz_oejMRep6KLbG8g9Pn5VxSUz42krvIm-VxCArFxf7c2LUoYwlraOb91MNCDWn8ecK7f0fuN2fgumeLRFKeOunrPksAeaFATYvL2D1hrDrvumPksNiAb3wHPOky_tsX7wBgSx977b2lz0bjRQcYxQZTtb4yj6UiGcMRRbH62wpXwuC1XaiMwFUkSkMEyj-GbA2ZRC466WaH3Y5k-Ta6wxUmCCTdy1nK3Cg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHUEYCROW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHUEYCROW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

