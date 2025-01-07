module 0x38eb0fc85685b7343db57bbe74415b2fd6246d239f3969dea955eaeb25c1a078::task3 {
    struct FirmaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct FirmaNftMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct FirmaNftTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct FirmaNftBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public entry fun transfer(arg0: FirmaNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FirmaNftTransferEvent{
            object_id : 0x2::object::id<FirmaNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<FirmaNftTransferEvent>(v0);
        0x2::transfer::public_transfer<FirmaNFT>(arg0, arg1);
    }

    public fun url(arg0: &FirmaNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: FirmaNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let FirmaNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = FirmaNftBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<FirmaNftBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &FirmaNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FirmaNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"FirmaNft"),
            description : 0x1::string::utf8(b"firma's NFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/2088807?v=4"),
        };
        let v1 = FirmaNftMintEvent{
            object_id : 0x2::object::id<FirmaNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v0.name,
        };
        0x2::event::emit<FirmaNftMintEvent>(v1);
        0x2::transfer::public_transfer<FirmaNFT>(v0, arg0);
    }

    public fun name(arg0: &FirmaNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun update_description(arg0: &mut FirmaNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

