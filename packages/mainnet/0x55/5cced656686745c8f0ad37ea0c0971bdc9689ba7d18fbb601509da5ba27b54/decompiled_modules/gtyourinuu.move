module 0x555cced656686745c8f0ad37ea0c0971bdc9689ba7d18fbb601509da5ba27b54::gtyourinuu {
    struct GTYOURINUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTYOURINUU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTYOURINUU>(arg0, 9, 0x1::string::utf8(b"GTYOURINUU"), 0x1::string::utf8(b"yourinuu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/vua-dFB6-2Jw7UstpdUMjP2XKLMmcNDQD6DaB2jaX2qEdA6rbo9uHU-s-FQUZRtlDxLQ73TjxnUG4aKpR9kbOBGqZSsUmwAHRZ9N8x4lURRU0zASE5BYCD6EPIWFf5chEtHsxV4vYKdMOiaeb6uwdMZCydcIF8sSItaNg_M8y1uqNf_ti5V01QMe7d7mg4gUG3xNwJ27_kU2O7pruqKMAJncs4Q8xUifK2cU7Ny-bsG1KisBu1ZDMiGF7V1qr91NRBVGzREoR1PdUOBI0YwUxmfqtPQxAziAekXeuzA3OB6_gujTus1XRVlbWOw0rjzwHiE4Ww10NRAXXGj6xOI0TA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTYOURINUU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTYOURINUU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

