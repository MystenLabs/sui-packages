module 0xb857993b47d366aeca2edb781baed22d56be3f2797a149e8253be86cf15ab0cc::ebh {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        name: 0x1::string::String,
        recipient: address,
    }

    public fun creator(arg0: &MyNFT) : address {
        arg0.creator
    }

    public fun description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &MyNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id           : 0x2::object::new(arg0),
            total_minted : 0,
            max_supply   : 100,
        };
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun max_supply(arg0: &MintCap) : u64 {
        arg0.max_supply
    }

    public entry fun mint_nft(arg0: &mut MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_minted < arg0.max_supply, 0);
        let v0 = MyNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            creator     : 0x2::tx_context::sender(arg5),
        };
        arg0.total_minted = arg0.total_minted + 1;
        let v1 = NFTMinted{
            nft_id    : 0x2::object::uid_to_address(&v0.id),
            name      : v0.name,
            recipient : arg4,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<MyNFT>(v0, arg4);
    }

    public entry fun mint_to_sender(arg0: &mut MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        mint_nft(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun total_minted(arg0: &MintCap) : u64 {
        arg0.total_minted
    }

    public entry fun transfer_nft(arg0: MyNFT, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut MyNFT, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

