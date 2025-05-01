module 0x490c9f6a630e2ae9cc6c6b5dea2e284f4d3603174314cd1c3d68c13ea6a23d67::wwwq {
    struct WWWQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWWQ, arg1: &mut 0x2::tx_context::TxContext) {
        0xc4f19682f340eb849149241d08287ff5a2752ae55ac8772913d1ba25c1dadb08::connector_v4::new<WWWQ>(arg0, 801354506, b"WWWQ", b"wwwq", b"{\"shortDescription\":\"wwwqwwwqwwwqwwwq\",\"personality\":\"\",\"goals\":\"\",\"background\":\"\",\"githubProject\":\"\",\"customFields\":{}}", b"https://vram.mypinata.cloud/ipfs/bafkreidyy4c4oa34amoxd2e5f2e5yrtevn33kmdanpegyhsfosufvffhc4", 0x1::string::utf8(b"https://x.com/vramxai"), 0x1::string::utf8(b"https://vram.ai"), 0x1::string::utf8(b"https://t.me/vram_ai"), arg1);
    }

    // decompiled from Move bytecode v6
}

