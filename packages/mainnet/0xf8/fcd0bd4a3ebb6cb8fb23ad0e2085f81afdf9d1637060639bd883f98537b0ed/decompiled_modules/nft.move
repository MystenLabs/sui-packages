module 0xf8fcd0bd4a3ebb6cb8fb23ad0e2085f81afdf9d1637060639bd883f98537b0ed::nft {
    struct Mynft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Mynft{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"dr1am1 nft"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/157526753?v=4"),
        };
        0x2::transfer::transfer<Mynft>(v0, @0x7b8e0864967427679b4e129f79dc332a885c6087ec9e187b53451a9006ee15f2);
    }

    // decompiled from Move bytecode v6
}

