module 0x7cdcbc1a971df65993698d6d5a67e4fad62c323a5609a8cb1fafd9a3c956d4cb::a_aaron_cheng_hao_nft {
    struct A_AARON_CHENG_HAO_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        recipient: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &A_AARON_CHENG_HAO_NFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: A_AARON_CHENG_HAO_NFT) {
        let A_AARON_CHENG_HAO_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &A_AARON_CHENG_HAO_NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_and_transfer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = A_AARON_CHENG_HAO_NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg4),
            recipient : arg3,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<A_AARON_CHENG_HAO_NFT>(v0, arg3);
    }

    public fun name(arg0: &A_AARON_CHENG_HAO_NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut A_AARON_CHENG_HAO_NFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

