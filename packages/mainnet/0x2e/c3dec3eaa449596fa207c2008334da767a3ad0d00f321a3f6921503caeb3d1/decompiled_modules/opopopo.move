module 0x2ec3dec3eaa449596fa207c2008334da767a3ad0d00f321a3f6921503caeb3d1::opopopo {
    struct OPOPOPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPOPOPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x415857b748ca0787d5e26f6ae07c03b94941c1f49a4c879c4499305cbbe3c8f6::connector_v3::new<OPOPOPO>(arg0, 108471298, b"OPOPOPO", b"opopopo", b"[object Object]", b"https://vram.mypinata.cloud/ipfs/bafkreif257qxloxlx5653kgzb3pghe7gz6fv4bvuusxsiyxdvfy3pghlcy", 0x1::string::utf8(b"https://x.com/vramxai"), 0x1::string::utf8(b"https://vram.ai"), 0x1::string::utf8(b"https://t.me/vram_ai"), arg1);
    }

    // decompiled from Move bytecode v6
}

