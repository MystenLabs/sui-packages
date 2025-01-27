module 0x40766b24fccda3b09298c2551d6ef9cb513cefba99ba343ce3a7b4d72106f81::suilaxy_nft {
    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTShop has key {
        id: 0x2::object::UID,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ProfitsCollected has copy, drop {
        amount: u64,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun collect_profits(arg0: &AdminCap, arg1: &mut NFTShop, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xa84a74d18762c8981749f539849f72888ffe554069d6b37451aff73d6c20c171, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        let v1 = ProfitsCollected{amount: v0};
        0x2::event::emit<ProfitsCollected>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2), @0xa84a74d18762c8981749f539849f72888ffe554069d6b37451aff73d6c20c171);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x476aa5cda4a10276eb02d9b38e148c5186915cd47c5dffbf1ef14d4af3083263, 0);
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 20000,
        };
        0x2::transfer::share_object<Counter>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, @0xa84a74d18762c8981749f539849f72888ffe554069d6b37451aff73d6c20c171);
        let v2 = NFTShop{
            id      : 0x2::object::new(arg0),
            price   : 500000000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<NFTShop>(v2);
    }

    fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) : 0x40766b24fccda3b09298c2551d6ef9cb513cefba99ba343ce3a7b4d72106f81::create_nft_with_random_attributes::NFT {
        0x40766b24fccda3b09298c2551d6ef9cb513cefba99ba343ce3a7b4d72106f81::create_nft_with_random_attributes::create_nft_with_attributes_from_frame(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    entry fun send_nft_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::random::Random, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut NFTShop, arg7: &mut Counter, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_to_sender(arg0, arg1, arg2, arg3, arg4, arg8);
        assert!(arg7.value > 0, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg6.price, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg6.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let v1 = NFTMinted{
            object_id : 0x2::object::uid_to_inner(0x40766b24fccda3b09298c2551d6ef9cb513cefba99ba343ce3a7b4d72106f81::create_nft_with_random_attributes::get_nft_uid(&v0)),
            creator   : 0x2::tx_context::sender(arg8),
            name      : arg0,
        };
        0x2::event::emit<NFTMinted>(v1);
        arg7.value = arg7.value - 1;
        0x2::transfer::public_transfer<0x40766b24fccda3b09298c2551d6ef9cb513cefba99ba343ce3a7b4d72106f81::create_nft_with_random_attributes::NFT>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

