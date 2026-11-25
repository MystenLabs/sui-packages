module 0x3fedb6143bfd4708d12596c54828ef65eb440c9889166d30bf68d129e4f1cbcb::gtatralama {
    struct GTATRALAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTATRALAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTATRALAMA>(arg0, 9, 0x1::string::utf8(b"GTATRALAMA"), 0x1::string::utf8(b"Atral"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/OffYU7oS5M3kvtFa_EK_Cy5OxD1h-it1mcUlRHhyRk0H_YCKYz9UJ4xa1O2tom26WnM0uPZ2UeKix57BoHgvVXRYLFvA5QDq3ec6TFfiF8s00XJpIw1zNtWVfw5eo6FLwioLUi2Pv_7N52o8N4BOEyAF5gN8RQSSsCkfkCij0dd3bkC3dum0WVC0y41WCHUE7D93oKghE6eKaeDYg5tDA6kkFegP9PSvuTZzvDV-5Kv13HRUkL6sxuRyDdbd7SfByHIE8q7Ng-NS5xgaFu_QFK_vIsD2BMiBIc4B_bD9X4Cwfnntssjc0JReu2QXtrzOdnRjeOxKc8pDhEVd0dLyGQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTATRALAMA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTATRALAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

