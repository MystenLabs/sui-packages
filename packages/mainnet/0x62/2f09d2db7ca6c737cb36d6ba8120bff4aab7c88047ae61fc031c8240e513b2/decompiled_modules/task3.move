module 0x622f09d2db7ca6c737cb36d6ba8120bff4aab7c88047ae61fc031c8240e513b2::task3 {
    struct Beson77NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Beson77NFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Beson77-NFT"),
            description : 0x1::string::utf8(b"Beson77-NFT desc"),
            image_url   : arg0,
        };
        0x2::transfer::transfer<Beson77NFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

