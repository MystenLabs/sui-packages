module 0x3e07f5f4210a5b445007da014f77b9ed64674221ffbdf732231b2f272a01cb9d::yug {
    struct YUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUG, arg1: &mut 0x2::tx_context::TxContext) {
        0xc4f19682f340eb849149241d08287ff5a2752ae55ac8772913d1ba25c1dadb08::connector_v4::new<YUG>(arg0, 798258943, b"YUG", b"yug", b"{\"shortDescription\":\"yugyugyugyug\",\"personality\":\"\",\"goals\":\"\",\"background\":\"\",\"githubProject\":\"\",\"customFields\":{}}", b"https://vram.mypinata.cloud/ipfs/bafkreiceh4fiyejzyolvy722thkh3h4srivnjjvs72ekujot7v5q6wy3tu", 0x1::string::utf8(b"https://x.com/vramxai"), 0x1::string::utf8(b"https://vram.ai"), 0x1::string::utf8(b"https://t.me/vram_ai"), arg1);
    }

    // decompiled from Move bytecode v6
}

