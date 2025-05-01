module 0x1027e556c6fb3ec92120ec3af444e90f9dff146b9c7343428099d238432bf6cf::yuyuqq {
    struct YUYUQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUYUQQ, arg1: &mut 0x2::tx_context::TxContext) {
        0xc4f19682f340eb849149241d08287ff5a2752ae55ac8772913d1ba25c1dadb08::connector_v4::new<YUYUQQ>(arg0, 116529110, b"YUYUQQ", b"yuyuqq", b"{\"shortDescription\":\"yuyuqqyuyuqqyuyuqqyuyuqq\",\"personality\":\"\",\"goals\":\"\",\"background\":\"\",\"githubProject\":\"\",\"customFields\":{}}", b"https://vram.mypinata.cloud/ipfs/bafkreibir7jdmyjaqxgy3v3dl5e7xs25l2zx2grtck5kho36tgbttvlz7q", 0x1::string::utf8(b"https://x.com/vramxai"), 0x1::string::utf8(b"https://vram.ai"), 0x1::string::utf8(b"https://t.me/vram_ai"), arg1);
    }

    // decompiled from Move bytecode v6
}

