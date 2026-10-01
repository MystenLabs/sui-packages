module 0x5e7dfb0ed349577b66c8d9da62a3cb47e072e2910661acc7fdf629c593f78950::nugget {
    struct NUGGET has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        creator: address,
        validator: address,
        price: u64,
        minted: u64,
        supply: u64,
        open: bool,
    }

    struct Nugget has store, key {
        id: 0x2::object::UID,
        number: u64,
        stake: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        validator: address,
        principal: u64,
        creator: address,
    }

    struct Minted has copy, drop {
        nugget: 0x2::object::ID,
        number: u64,
        principal: u64,
        validator: address,
        activation_epoch: u64,
        minter: address,
    }

    struct Burned has copy, drop {
        nugget: 0x2::object::ID,
        number: u64,
        principal: u64,
        redeemed: u64,
        holder: address,
    }

    struct Harvested has copy, drop {
        nugget: 0x2::object::ID,
        number: u64,
        reward: u64,
        activation_epoch: u64,
        holder: address,
    }

    public fun activation_epoch(arg0: &Nugget) : u64 {
        0x3::staking_pool::stake_activation_epoch(0x1::option::borrow<0x3::staking_pool::StakedSui>(&arg0.stake))
    }

    public fun burn(arg0: Nugget, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let Nugget {
            id        : v0,
            number    : v1,
            stake     : v2,
            validator : _,
            principal : v4,
            creator   : _,
        } = arg0;
        let v6 = v2;
        let v7 = v0;
        0x1::option::destroy_none<0x3::staking_pool::StakedSui>(v6);
        0x2::object::delete(v7);
        let v8 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut v6), arg2);
        let v9 = Burned{
            nugget    : 0x2::object::uid_to_inner(&v7),
            number    : v1,
            principal : v4,
            redeemed  : 0x2::balance::value<0x2::sui::SUI>(&v8),
            holder    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burned>(v9);
        0x2::coin::from_balance<0x2::sui::SUI>(v8, arg2)
    }

    entry fun burn_to(arg0: Nugget, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(burn(arg0, arg1, arg3), arg2);
    }

    public fun close(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.open = false;
    }

    public fun create_collection(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id        : 0x2::object::new(arg4),
            creator   : 0x2::tx_context::sender(arg4),
            validator : arg1,
            price     : arg2,
            minted    : 0,
            supply    : arg3,
            open      : true,
        };
        0x2::transfer::share_object<Collection>(v0);
    }

    public fun creator(arg0: &Nugget) : address {
        arg0.creator
    }

    fun forge(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : Nugget {
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg0, arg1, arg2, arg5);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x3::staking_pool::staked_sui_amount(&v0);
        let v3 = Minted{
            nugget           : 0x2::object::uid_to_inner(&v1),
            number           : arg3,
            principal        : v2,
            validator        : arg2,
            activation_epoch : 0x3::staking_pool::stake_activation_epoch(&v0),
            minter           : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Minted>(v3);
        Nugget{
            id        : v1,
            number    : arg3,
            stake     : 0x1::option::some<0x3::staking_pool::StakedSui>(v0),
            validator : arg2,
            principal : v2,
            creator   : arg4,
        }
    }

    public fun harvest(arg0: &mut Nugget, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut arg0.stake), arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) > arg0.principal, 4);
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::take<0x2::sui::SUI>(&mut v0, arg0.principal, arg2), arg0.validator, arg2);
        assert!(0x3::staking_pool::staked_sui_amount(&v1) == arg0.principal, 5);
        let v2 = Harvested{
            nugget           : 0x2::object::uid_to_inner(&arg0.id),
            number           : arg0.number,
            reward           : 0x2::balance::value<0x2::sui::SUI>(&v0),
            activation_epoch : 0x3::staking_pool::stake_activation_epoch(&v1),
            holder           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Harvested>(v2);
        0x1::option::fill<0x3::staking_pool::StakedSui>(&mut arg0.stake, v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2)
    }

    entry fun harvest_to(arg0: &mut Nugget, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(harvest(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NUGGET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NUGGET>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"principal"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"validator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"number"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Gold Nugget #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A nugget with real gold inside: a native Sui staking position. The holder can harvest the accrued rewards at any time, but the principal can only be recovered by burning the nugget. Everything inside is verifiable on chain by anyone."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://goldnuggetsales.com/images/11-25-25%20TM%20RB%20M%20T%20California%20Natural%20Gold%20Nugget--45.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://goldnuggetsales.com/images/11-25-25%20TM%20RB%20M%20T%20California%20Natural%20Gold%20Nugget--45.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suivision.xyz/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suivision.xyz/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{principal}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{validator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{number}"));
        let v5 = 0x2::display::new_with_fields<Nugget>(&v0, v1, v3, arg1);
        0x2::display::update_version<Nugget>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nugget>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut Collection, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open, 3);
        assert!(arg0.minted < arg0.supply, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.price, 1);
        arg0.minted = arg0.minted + 1;
        0x2::kiosk::place<Nugget>(arg3, arg4, forge(arg1, arg2, arg0.validator, arg0.minted, arg0.creator, arg5));
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun number(arg0: &Nugget) : u64 {
        arg0.number
    }

    public fun pool(arg0: &Nugget) : 0x2::object::ID {
        0x3::staking_pool::pool_id(0x1::option::borrow<0x3::staking_pool::StakedSui>(&arg0.stake))
    }

    public fun price(arg0: &Collection) : u64 {
        arg0.price
    }

    public fun principal(arg0: &Nugget) : u64 {
        arg0.principal
    }

    public fun supply(arg0: &Collection) : u64 {
        arg0.supply
    }

    public fun validator(arg0: &Nugget) : address {
        arg0.validator
    }

    // decompiled from Move bytecode v7
}

