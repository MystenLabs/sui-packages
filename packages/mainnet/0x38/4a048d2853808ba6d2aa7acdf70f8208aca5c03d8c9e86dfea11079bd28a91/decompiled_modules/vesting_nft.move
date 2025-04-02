module 0x384a048d2853808ba6d2aa7acdf70f8208aca5c03d8c9e86dfea11079bd28a91::vesting_nft {
    struct VestingNft<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        owner: address,
        tokens: 0x2::balance::Balance<T0>,
        vesting_expiration: u64,
        presale_origin_id: 0x2::object::ID,
    }

    struct VestingNftMinted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        token_amount: u64,
        vesting_expiration: u64,
        presale_origin_id: 0x2::object::ID,
    }

    struct VestingNftUnlocked has copy, drop {
        vesting_nft_id: 0x2::object::ID,
        presale_origin_id: 0x2::object::ID,
        owner: address,
        tokens_unlocked: u64,
        timestamp: u64,
    }

    public fun url<T0>(arg0: &VestingNft<T0>) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn<T0>(arg0: VestingNft<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.vesting_expiration, 1);
        let VestingNft {
            id                 : v0,
            name               : _,
            description        : _,
            url                : _,
            owner              : v4,
            tokens             : v5,
            vesting_expiration : _,
            presale_origin_id  : _,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v4);
        0x2::object::delete(v0);
    }

    public fun description<T0>(arg0: &VestingNft<T0>) : &0x1::string::String {
        &arg0.description
    }

    public fun locked_balance<T0>(arg0: &VestingNft<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun mint<T0>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::url::Url, arg7: &mut 0x2::tx_context::TxContext) : VestingNft<T0> {
        let v0 = VestingNft<T0>{
            id                 : 0x2::object::new(arg7),
            name               : arg4,
            description        : arg5,
            url                : arg6,
            owner              : arg0,
            tokens             : arg1,
            vesting_expiration : arg2,
            presale_origin_id  : arg3,
        };
        let v1 = VestingNftMinted{
            object_id          : 0x2::object::id<VestingNft<T0>>(&v0),
            owner              : arg0,
            token_amount       : 0x2::balance::value<T0>(&arg1),
            vesting_expiration : arg2,
            presale_origin_id  : arg3,
        };
        0x2::event::emit<VestingNftMinted>(v1);
        v0
    }

    public fun name<T0>(arg0: &VestingNft<T0>) : &0x1::string::String {
        &arg0.name
    }

    public fun owner<T0>(arg0: &VestingNft<T0>) : address {
        arg0.owner
    }

    public fun presale_origin_id<T0>(arg0: &VestingNft<T0>) : 0x2::object::ID {
        arg0.presale_origin_id
    }

    public fun transfer_to_sender<T0>(arg0: VestingNft<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VestingNft<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun unlock_tokens<T0>(arg0: VestingNft<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.vesting_expiration, 1);
        let VestingNft {
            id                 : v1,
            name               : _,
            description        : _,
            url                : _,
            owner              : v5,
            tokens             : v6,
            vesting_expiration : _,
            presale_origin_id  : v8,
        } = arg0;
        let v9 = v6;
        let v10 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg2), v5);
        0x2::object::delete(v10);
        let v11 = VestingNftUnlocked{
            vesting_nft_id    : 0x2::object::uid_to_inner(&v10),
            presale_origin_id : v8,
            owner             : v5,
            tokens_unlocked   : 0x2::balance::value<T0>(&v9),
            timestamp         : v0,
        };
        0x2::event::emit<VestingNftUnlocked>(v11);
    }

    public fun vesting_expiration<T0>(arg0: &VestingNft<T0>) : u64 {
        arg0.vesting_expiration
    }

    // decompiled from Move bytecode v6
}

