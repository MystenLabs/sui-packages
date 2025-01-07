module 0xefd1547a8aa043746ecf817babf1e0de465a132963498868fc6ca75b7c5d2bff::roaring_kitties {
    struct Nft has store, key {
        id: 0x2::object::UID,
        group_id: 0x1::string::String,
        type1: u64,
        name: 0x1::string::String,
        index: u64,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public entry fun nft_to_sender(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Nft{
            id          : 0x2::object::new(arg6),
            group_id    : 0x1::string::utf8(arg0),
            type1       : arg1,
            name        : 0x1::string::utf8(arg2),
            index       : arg3,
            description : 0x1::string::utf8(arg4),
            media_url   : 0x1::string::utf8(arg5),
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::transfer::public_transfer<Nft>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

