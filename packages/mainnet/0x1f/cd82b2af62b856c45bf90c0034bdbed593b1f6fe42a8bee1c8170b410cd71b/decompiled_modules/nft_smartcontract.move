module 0x1fcd82b2af62b856c45bf90c0034bdbed593b1f6fe42a8bee1c8170b410cd71b::nft_smartcontract {
    struct NftSmartcontract has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: NftSmartcontract, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NftSmartcontract>(arg0, arg1);
    }

    public fun url(arg0: &NftSmartcontract) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: NftSmartcontract, arg1: &mut 0x2::tx_context::TxContext) {
        let NftSmartcontract {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &NftSmartcontract) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_recipient(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NftSmartcontract{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<NftSmartcontract>(&v0),
            creator   : arg3,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NftSmartcontract>(v0, arg3);
    }

    public fun name(arg0: &NftSmartcontract) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut NftSmartcontract, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

