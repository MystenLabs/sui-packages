module 0x74fe2983c3a9e1871f5c4afea891a906782bc97c5945dd61a066ef64012c5c3b::gttomuraa6 {
    struct GTTOMURAA6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTOMURAA6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTOMURAA6>(arg0, 9, 0x1::string::utf8(b"GTTOMURAA6"), 0x1::string::utf8(b"tomuraaa"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/CszzGOgYEOEmEOeAHJP8j9meudMfCWdgh0w7hBd3gy0-LzBCdmgzY_Fz4uv4XJKJqiyUgs8CkNZdgPorAcDFt_MincFMHGSJXtGbH_weQO8rQgFWQbI7_BpWbE5-IljeCBbSPJWwkkHiMn7GAlDYHAsSXL257YIrCoqtW2gWo9_qZbm0xwcmzkCUmz61ulSwtrjYCmfLag55JdlkrG3fbUpwvQ1QbjfF_4hmNPSmGHLG3b0AjWOevd5OTg3w8sKHy0_UTxFbrnwwAs7OUPg3c3TFliVzQFsUg074rwIXUcclRCsGYzg1wdFKh5QT1Hv9ao63gNkBXBhsWcuvEHo6iA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTOMURAA6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTOMURAA6>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

