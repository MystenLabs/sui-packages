module 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::mint {
    struct Mint has store, key {
        id: 0x2::object::UID,
        referrals: 0x2::table::Table<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>,
        total_quantity: u64,
        quantities: vector<u64>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        price: u64,
        is_mint_chest_open: bool,
        is_mint_clover_open: bool,
        limit_per_address: u64,
    }

    struct Threshold has copy, drop, store {
        index: u64,
        threshold: u64,
    }

    struct MintChestEvent has copy, drop, store {
        chest_id: 0x2::object::ID,
        sender: address,
        code: 0x1::option::Option<0x1::string::String>,
    }

    struct MintCloverEvent has copy, drop, store {
        chest_id: 0x2::object::ID,
        clover_id: 0x2::object::ID,
        sender: address,
    }

    public fun add_referral(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address) {
        0x2::table::add<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&mut arg1.referrals, arg2, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::create_referral(arg3, arg4, arg5, arg6));
    }

    public fun change_is_mint_chest_open(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: bool) {
        arg1.is_mint_chest_open = arg2;
    }

    public fun change_is_mint_clover_open(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: bool) {
        arg1.is_mint_clover_open = arg2;
    }

    public fun change_limit_per_address(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: u64) {
        arg1.limit_per_address = arg2;
    }

    public fun change_price(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: u64) {
        arg1.price = arg2;
    }

    public fun change_quantities(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: vector<u64>) {
        arg1.quantities = arg2;
    }

    public fun change_referral_commission(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: u64) {
        0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::change_commission(0x2::table::borrow_mut<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun change_referral_discount(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: u64) {
        0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::change_discount(0x2::table::borrow_mut<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun change_referral_receiver_address(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: address) {
        0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::change_receiver_address(0x2::table::borrow_mut<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun change_total_quantity(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: u64) {
        arg1.total_quantity = arg2;
    }

    public fun claim_balance(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2)
    }

    public fun claim_referral_balance(arg0: &mut Mint, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&mut arg0.referrals, arg1);
        assert!(0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::balance_value(v0) > 0, 4);
        assert!(0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::receiver_address(v0) == 0x2::tx_context::sender(arg2), 5);
        0x2::coin::from_balance<0x2::sui::SUI>(0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::withdraw(v0), arg2)
    }

    public fun get_discounted_price(arg0: &Mint, arg1: 0x1::option::Option<0x1::string::String>) : (u64, u64) {
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v2 = 0x2::table::borrow<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&arg0.referrals, 0x1::option::destroy_some<0x1::string::String>(arg1));
            let v3 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(arg0.price, 1000 - 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::discount(v2), 1000);
            (v3, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(v3, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::commission(v2), 1000))
        } else {
            (arg0.price, 0)
        }
    }

    public fun how_much_address_can_mint(arg0: &Mint, arg1: address) : u64 {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            arg0.limit_per_address - *0x2::dynamic_field::borrow<address, u64>(&arg0.id, arg1)
        } else {
            arg0.limit_per_address
        }
    }

    public fun how_much_address_minted(arg0: &Mint, arg1: address) : u64 {
        *0x2::dynamic_field::borrow<address, u64>(&arg0.id, arg1)
    }

    public fun is_mint_chest_open(arg0: &Mint) : bool {
        arg0.is_mint_chest_open
    }

    public fun is_mint_clover_open(arg0: &Mint) : bool {
        arg0.is_mint_clover_open
    }

    public fun limit_per_address(arg0: &Mint) : u64 {
        arg0.limit_per_address
    }

    public fun mint_chest(arg0: &mut Mint, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::chest::SamChest {
        assert!(arg0.is_mint_chest_open, 0);
        let v0 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v1 = 0x2::table::borrow_mut<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&mut arg0.referrals, 0x1::option::destroy_some<0x1::string::String>(arg1));
            let v2 = 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::commission(v1);
            let v3 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(arg0.price, 1000 - 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::discount(v1), 1000);
            0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::join(v1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(v3, v2, 1000), arg3));
            0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::new_sale(v1);
            v3
        } else {
            arg0.price
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 1);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = if (0x2::dynamic_field::exists_<address>(&arg0.id, v4)) {
            assert!(*0x2::dynamic_field::borrow<address, u64>(&arg0.id, v4) < arg0.limit_per_address, 2);
            0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, v4)
        } else {
            0x2::dynamic_field::add<address, u64>(&mut arg0.id, v4, 0);
            0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, v4)
        };
        *v5 = *v5 + 1;
        arg0.total_quantity = arg0.total_quantity + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v6 = 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::chest::mint(arg3);
        let v7 = MintChestEvent{
            chest_id : 0x2::object::id<0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::chest::SamChest>(&v6),
            sender   : v4,
            code     : arg1,
        };
        0x2::event::emit<MintChestEvent>(v7);
        v6
    }

    entry fun mint_clover(arg0: &mut Mint, arg1: 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::chest::SamChest, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::clover::SamClover>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_mint_clover_open, 3);
        0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::chest::burn(arg1);
        let v0 = 0;
        let v1 = arg0.quantities;
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut v1);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        let v3 = 0x1::vector::empty<Threshold>();
        let v4 = 0;
        let v5 = 0;
        let v6 = &arg0.quantities;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(v6)) {
            let v8 = *0x1::vector::borrow<u64>(v6, v7);
            if (v8 > 0) {
                let v9 = v4 + v8;
                v4 = v9;
                let v10 = Threshold{
                    index     : v5,
                    threshold : v9,
                };
                0x1::vector::push_back<Threshold>(&mut v3, v10);
            };
            v5 = v5 + 1;
            v7 = v7 + 1;
        };
        let v11 = 0x2::random::new_generator(arg5, arg6);
        v5 = 0;
        while (0x1::vector::length<Threshold>(&v3) > v5) {
            let v12 = *0x1::vector::borrow<Threshold>(&v3, v5);
            if (v12.threshold >= 0x2::random::generate_u64_in_range(&mut v11, 1, v0)) {
                let v13 = 0x1::vector::borrow_mut<u64>(&mut arg0.quantities, v12.index);
                *v13 = *v13 - 1;
                let v14 = 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::clover::mint(arg6, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::clover::index_to_clover_type(v12.index));
                let v15 = MintCloverEvent{
                    chest_id  : 0x2::object::id<0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::chest::SamChest>(&arg1),
                    clover_id : 0x2::object::id<0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::clover::SamClover>(&v14),
                    sender    : 0x2::tx_context::sender(arg6),
                };
                0x2::event::emit<MintCloverEvent>(v15);
                0x2::kiosk::lock<0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::clover::SamClover>(arg2, arg3, arg4, v14);
                break
            };
            v5 = v5 + 1;
        };
    }

    public(friend) fun new_mint(arg0: u64, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Mint{
            id                  : 0x2::object::new(arg4),
            referrals           : 0x2::table::new<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(arg4),
            total_quantity      : arg0,
            quantities          : arg1,
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            price               : arg2,
            is_mint_chest_open  : false,
            is_mint_clover_open : false,
            limit_per_address   : arg3,
        };
        0x2::transfer::public_share_object<Mint>(v0);
    }

    public fun price(arg0: &Mint) : u64 {
        arg0.price
    }

    public fun quantities(arg0: &Mint) : vector<u64> {
        arg0.quantities
    }

    public fun remove_referral(arg0: &0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::burn(0x2::table::remove<0x1::string::String, 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun total_quantity(arg0: &Mint) : u64 {
        arg0.total_quantity
    }

    // decompiled from Move bytecode v6
}

