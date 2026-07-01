module 0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha_nft {
    struct BlackRabbitNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        owner: address,
    }

    struct NFTCollection has key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
        mint_price: u64,
        royalty_bps: u64,
        treasury: 0x2::balance::Balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>,
    }

    struct NFTMinted has copy, drop {
        token_id: u64,
        owner: address,
    }

    struct NFTTransferred has copy, drop {
        token_id: u64,
        from: address,
        to: address,
    }

    public entry fun create_collection(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTCollection{
            id           : 0x2::object::new(arg0),
            total_minted : 0,
            max_supply   : 4500,
            mint_price   : 100000000,
            royalty_bps  : 500,
            treasury     : 0x2::balance::zero<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(),
        };
        0x2::transfer::share_object<NFTCollection>(v0);
    }

    public fun max_supply(arg0: &NFTCollection) : u64 {
        arg0.max_supply
    }

    public entry fun mint_nft(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_minted < arg0.max_supply, 0);
        assert!(0x2::coin::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg1) >= arg0.mint_price, 1);
        arg0.total_minted = arg0.total_minted + 1;
        let v0 = arg0.total_minted;
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.treasury, 0x2::coin::into_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(arg1));
        let v2 = BlackRabbitNFT{
            id          : 0x2::object::new(arg2),
            token_id    : v0,
            name        : 0x1::string::utf8(b"Black Rabbit #"),
            description : 0x1::string::utf8(b"Black Rabbit NFT Collection by ARTHA Ecosystem"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://artha.world/nft/black-rabbit.png"),
            owner       : v1,
        };
        let v3 = NFTMinted{
            token_id : v0,
            owner    : v1,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<BlackRabbitNFT>(v2, v1);
    }

    public fun nft_token_id(arg0: &BlackRabbitNFT) : u64 {
        arg0.token_id
    }

    public fun total_minted(arg0: &NFTCollection) : u64 {
        arg0.total_minted
    }

    public entry fun transfer_nft(arg0: BlackRabbitNFT, arg1: &mut NFTCollection, arg2: 0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::balance::join<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg1.treasury, 0x2::coin::into_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(0x2::coin::split<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg2, 0x2::coin::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg2) * arg1.royalty_bps / 10000, arg4)));
        let v1 = NFTTransferred{
            token_id : arg0.token_id,
            from     : v0,
            to       : arg3,
        };
        0x2::event::emit<NFTTransferred>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>>(arg2, v0);
        0x2::transfer::public_transfer<BlackRabbitNFT>(arg0, arg3);
    }

    public fun treasury_balance(arg0: &NFTCollection) : u64 {
        0x2::balance::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg0.treasury)
    }

    public entry fun withdraw_treasury(arg0: &mut NFTCollection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>>(0x2::coin::from_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(0x2::balance::split<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.treasury, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

