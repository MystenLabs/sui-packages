module 0x92ae3c6a92df0d51aead00c347e7abec1cd166ba54ba2d1c546796b76e632ef3::ggb {
    struct GGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GGB>(arg0, 8681397368150920203, b"GG Bond", b"GGB", b"GG Bond is a community-driven meme token inspired by the iconic Chinese animated superhero character. Embodying the spirit of courage, friendship, and adventure, GG Bond token aims to bring together fans and crypto enthusiasts in a fun and engaging way. Join our vibrant community as we celebrate this beloved character in the Web3 space!", b"https://images.hop.ag/ipfs/QmVbmTUJkirDueaWgQXFCitSJ79VcejUStN4wogKFzCxKX", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

