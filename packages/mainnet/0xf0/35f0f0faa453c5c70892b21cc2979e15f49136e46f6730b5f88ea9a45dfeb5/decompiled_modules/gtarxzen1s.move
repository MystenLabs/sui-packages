module 0xf035f0f0faa453c5c70892b21cc2979e15f49136e46f6730b5f88ea9a45dfeb5::gtarxzen1s {
    struct GTARXZEN1S has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTARXZEN1S, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTARXZEN1S>(arg0, 9, 0x1::string::utf8(b"GTARXZEN1S"), 0x1::string::utf8(b"0xAL"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/PoRw3My476juwiEhSkWl-30_2JKJUf6dujFYmBvy0JkG-mD1A-i5QAOYv10Y1Dg_FrJkbHMQZt9lAW8uLyIdcHlGj13DgT83b-pQ8LSqQw5b1RdXbKug3KX8-wsAJ60lFCxyaDUCWaxXE_XqvmHcYPY71gCuC85pj-gzSHm6nAHwiP_ZJVu57LbsQ_k0-mbgd5TNBHYIll1cNpuEbIf_tBE2rxLDjb8nAF4L8xvdX0Qeh4GGZRKx0GkktazPvSkyWzjx_sETkYI8DUSJptCWxgIYrpkIxGApPAW99E1yt9B3oWhZpxK8RIMqhwoolQ6wPBTINgup-2nVfbbR7L6xhQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTARXZEN1S>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTARXZEN1S>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

