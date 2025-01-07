module 0x167bedc0df93a96eef56a9335140afa176bbf46e6634e03e529d94fe89f4620f::kael777_nft {
    struct Kael777Nft has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Kael777NftMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Kael777NftBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct Kael777NftTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public entry fun transfer(arg0: Kael777Nft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Kael777NftTransferEvent{
            object_id : 0x2::object::id<Kael777Nft>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<Kael777NftTransferEvent>(v0);
        0x2::transfer::public_transfer<Kael777Nft>(arg0, arg1);
    }

    public fun url(arg0: &Kael777Nft) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Kael777Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let Kael777Nft {
            id          : v0,
            creator     : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v5 = v0;
        let v6 = Kael777NftBurnEvent{object_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<Kael777NftBurnEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun description(arg0: &Kael777Nft) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Kael777Nft{
            id          : 0x2::object::new(arg3),
            creator     : 0x2::tx_context::sender(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = Kael777NftMinted{
            object_id : 0x2::object::id<Kael777Nft>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<Kael777NftMinted>(v1);
        0x2::transfer::public_transfer<Kael777Nft>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &Kael777Nft) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut Kael777Nft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

