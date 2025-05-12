module 0x6a783f7f10bf9b5b31d70f8f9a5dc9a6da3c9e688720bcaf3ce12bde07c2a5ef::byte {
    struct BYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYTE, arg1: &mut 0x2::tx_context::TxContext) {
        0x40998f8c129db75ae10a24a20d0d92ad99206b308f63a59cf29418cc19542f53::connector_v3::new<BYTE>(arg0, 7284250, b"BYTE", b"byte", b"bytbytbytbyt", b"https://vram.mypinata.cloud/ipfs/bafkreiceh4fiyejzyolvy722thkh3h4srivnjjvs72ekujot7v5q6wy3tu", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

