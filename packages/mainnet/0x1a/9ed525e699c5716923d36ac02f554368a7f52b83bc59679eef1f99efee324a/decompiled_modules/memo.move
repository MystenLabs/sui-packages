module 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::memo {
    public fun donate() : 0x1::string::String {
        0x1::string::utf8(b"cdp_donate")
    }

    public fun interest() : 0x1::string::String {
        0x1::string::utf8(b"cdp_interest")
    }

    public fun liquidate() : 0x1::string::String {
        0x1::string::utf8(b"cdp_liquidate")
    }

    public fun manage() : 0x1::string::String {
        0x1::string::utf8(b"cdp_manage")
    }

    // decompiled from Move bytecode v6
}

