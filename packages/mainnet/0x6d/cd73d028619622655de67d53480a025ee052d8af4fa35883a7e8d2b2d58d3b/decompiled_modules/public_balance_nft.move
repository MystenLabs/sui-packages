module 0x6dcd73d028619622655de67d53480a025ee052d8af4fa35883a7e8d2b2d58d3b::public_balance_nft {
    struct PublicBalanceNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
        owner_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        public_deposits_total: u64,
        created_at: u64,
    }

    struct PublicDepositKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PUBLIC_BALANCE_NFT has drop {
        dummy_field: bool,
    }

    struct Publisher has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        total_minted: u64,
        total_public_deposits: u64,
    }

    struct NFTMinted has copy, drop {
        id: address,
        name: 0x1::string::String,
        creator: address,
    }

    struct PublicDepositMade has copy, drop {
        nft_id: address,
        depositor: address,
        amount: u64,
        total_deposits: u64,
    }

    struct OwnerWithdrawal has copy, drop {
        nft_id: address,
        owner: address,
        amount: u64,
        remaining: u64,
    }

    public entry fun burn(arg0: PublicBalanceNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let PublicBalanceNFT {
            id                    : v0,
            name                  : _,
            description           : _,
            walrus_blob_id        : _,
            image_url             : _,
            creator               : _,
            owner_balance         : v6,
            public_deposits_total : _,
            created_at            : _,
        } = arg0;
        let v9 = v6;
        let v10 = v0;
        let v11 = 0x2::tx_context::sender(arg1);
        if (0x2::balance::value<0x2::sui::SUI>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg1), v11);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        };
        let v12 = PublicDepositKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PublicDepositKey>(&v10, v12)) {
            let v13 = PublicDepositKey{dummy_field: false};
            let v14 = 0x2::dynamic_field::remove<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v10, v13);
            if (0x2::balance::value<0x2::sui::SUI>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v14, arg1), v11);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
            };
        };
        0x2::object::delete(v10);
    }

    public entry fun deposit_to_nft(arg0: &mut PublicBalanceNFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = PublicDepositKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PublicDepositKey>(&arg0.id, v1)) {
            let v2 = PublicDepositKey{dummy_field: false};
            0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v2), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        } else {
            let v3 = PublicDepositKey{dummy_field: false};
            0x2::dynamic_field::add<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v3, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        };
        arg0.public_deposits_total = arg0.public_deposits_total + v0;
        let v4 = PublicDepositMade{
            nft_id         : 0x2::object::uid_to_address(&arg0.id),
            depositor      : 0x2::tx_context::sender(arg2),
            amount         : v0,
            total_deposits : arg0.public_deposits_total,
        };
        0x2::event::emit<PublicDepositMade>(v4);
    }

    public entry fun deposit_to_nft_by_split(arg0: &mut PublicBalanceNFT, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicDepositKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PublicDepositKey>(&arg0.id, v0)) {
            let v1 = PublicDepositKey{dummy_field: false};
            0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v1), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3)));
        } else {
            let v2 = PublicDepositKey{dummy_field: false};
            0x2::dynamic_field::add<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3)));
        };
        arg0.public_deposits_total = arg0.public_deposits_total + arg2;
        let v3 = PublicDepositMade{
            nft_id         : 0x2::object::uid_to_address(&arg0.id),
            depositor      : 0x2::tx_context::sender(arg3),
            amount         : arg2,
            total_deposits : arg0.public_deposits_total,
        };
        0x2::event::emit<PublicDepositMade>(v3);
    }

    public fun get_name(arg0: &PublicBalanceNFT) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner_balance(arg0: &PublicBalanceNFT) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.owner_balance)
    }

    public fun get_public_deposits(arg0: &PublicBalanceNFT) : u64 {
        let v0 = PublicDepositKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PublicDepositKey>(&arg0.id, v0)) {
            let v2 = PublicDepositKey{dummy_field: false};
            0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun get_total_balance(arg0: &PublicBalanceNFT) : u64 {
        get_public_deposits(arg0) + get_owner_balance(arg0)
    }

    fun init(arg0: PUBLIC_BALANCE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PUBLIC_BALANCE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"walrus_image"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"owner_balance"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"public_deposits"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/{walrus_blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{owner_balance} SUI"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{public_deposits_total} SUI"));
        let v5 = 0x2::display::new_with_fields<PublicBalanceNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<PublicBalanceNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<PublicBalanceNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Publisher{
            id                    : 0x2::object::new(arg1),
            publisher             : v0,
            total_minted          : 0,
            total_public_deposits : 0,
        };
        0x2::transfer::share_object<Publisher>(v6);
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut Publisher, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::utf8(arg2);
        assert!(!0x1::string::is_empty(&v0), 0);
        let v2 = 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/");
        0x1::string::append(&mut v2, v1);
        let v3 = PublicBalanceNFT{
            id                    : 0x2::object::new(arg5),
            name                  : v0,
            description           : 0x1::string::utf8(arg1),
            walrus_blob_id        : v1,
            image_url             : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v2)),
            creator               : 0x2::tx_context::sender(arg5),
            owner_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            public_deposits_total : 0,
            created_at            : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        arg4.total_minted = arg4.total_minted + 1;
        let v4 = NFTMinted{
            id      : 0x2::object::uid_to_address(&v3.id),
            name    : v3.name,
            creator : v3.creator,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<PublicBalanceNFT>(v3, arg3);
    }

    public entry fun owner_add_balance(arg0: &mut PublicBalanceNFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun transfer_nft(arg0: PublicBalanceNFT, arg1: address) {
        0x2::transfer::public_transfer<PublicBalanceNFT>(arg0, arg1);
    }

    public entry fun withdraw_all_public_deposits(arg0: &mut PublicBalanceNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicDepositKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PublicDepositKey>(&arg0.id, v0)) {
            let v1 = PublicDepositKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::remove<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v1);
            let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
            if (v3 > 0) {
                let v4 = 0x2::tx_context::sender(arg1);
                let v5 = OwnerWithdrawal{
                    nft_id    : 0x2::object::uid_to_address(&arg0.id),
                    owner     : v4,
                    amount    : v3,
                    remaining : 0,
                };
                0x2::event::emit<OwnerWithdrawal>(v5);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg1), v4);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
            };
        };
    }

    public entry fun withdraw_owner_balance(arg0: &mut PublicBalanceNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.owner_balance) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.owner_balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_public_deposits(arg0: &mut PublicBalanceNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicDepositKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<PublicDepositKey>(&arg0.id, v0), 1);
        let v1 = PublicDepositKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<PublicDepositKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<0x2::sui::SUI>(v2) >= arg1, 1);
        let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v2, arg1), arg2);
        let v4 = 0x2::tx_context::sender(arg2);
        let v5 = OwnerWithdrawal{
            nft_id    : 0x2::object::uid_to_address(&arg0.id),
            owner     : v4,
            amount    : arg1,
            remaining : 0x2::balance::value<0x2::sui::SUI>(v2),
        };
        0x2::event::emit<OwnerWithdrawal>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v4);
    }

    // decompiled from Move bytecode v6
}

