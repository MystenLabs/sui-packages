module 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::mint {
    struct MINT_RULE has copy, drop {
        dummy_field: bool,
    }

    struct Mint has store, key {
        id: 0x2::object::UID,
        referrals: 0x2::table::Table<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>,
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

    public fun add_referral(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address) {
        0x2::table::add<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&mut arg1.referrals, arg2, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::create_referral(arg3, arg4, arg5, arg6));
    }

    public fun change_is_mint_chest_open(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: bool) {
        arg1.is_mint_chest_open = arg2;
    }

    public fun change_is_mint_clover_open(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: bool) {
        arg1.is_mint_clover_open = arg2;
    }

    public fun change_limit_per_address(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: u64) {
        arg1.limit_per_address = arg2;
    }

    public fun change_price(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: u64) {
        arg1.price = arg2;
    }

    public fun change_quantities(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: vector<u64>) {
        arg1.quantities = arg2;
    }

    public fun change_referral_commission(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: u64) {
        0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::change_commission(0x2::table::borrow_mut<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun change_referral_discount(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: u64) {
        0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::change_discount(0x2::table::borrow_mut<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun change_referral_receiver_address(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: address) {
        0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::change_receiver_address(0x2::table::borrow_mut<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun change_total_quantity(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: u64) {
        arg1.total_quantity = arg2;
    }

    public fun claim_balance(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2)
    }

    public fun claim_referral_balance(arg0: &mut Mint, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&mut arg0.referrals, arg1);
        assert!(0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::balance_value(v0) > 0, 4);
        assert!(0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::receiver_address(v0) == 0x2::tx_context::sender(arg2), 5);
        0x2::coin::from_balance<0x2::sui::SUI>(0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::withdraw(v0), arg2)
    }

    public fun get_discounted_price(arg0: &Mint, arg1: 0x1::option::Option<0x1::string::String>) : (u64, u64) {
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v2 = 0x2::table::borrow<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&arg0.referrals, 0x1::option::destroy_some<0x1::string::String>(arg1));
            let v3 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(arg0.price, 1000 - 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::discount(v2), 1000);
            (v3, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(v3, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::commission(v2), 1000))
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

    public fun mint_chest(arg0: &mut Mint, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::SamChest {
        assert!(arg0.is_mint_chest_open, 0);
        let v0 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v1 = 0x2::table::borrow_mut<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&mut arg0.referrals, 0x1::option::destroy_some<0x1::string::String>(arg1));
            let v2 = 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::commission(v1);
            let v3 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(arg0.price, 1000 - 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::discount(v1), 1000);
            let v4 = 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(v3, v2, 1000);
            0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::join(v1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg3));
            0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::new_sale(v1);
            v3 - v4
        } else {
            arg0.price
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 1);
        let v5 = 0x2::tx_context::sender(arg3);
        let v6 = if (0x2::dynamic_field::exists_<address>(&arg0.id, v5)) {
            assert!(*0x2::dynamic_field::borrow<address, u64>(&arg0.id, v5) < arg0.limit_per_address, 2);
            0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, v5)
        } else {
            0x2::dynamic_field::add<address, u64>(&mut arg0.id, v5, 0);
            0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, v5)
        };
        *v6 = *v6 + 1;
        arg0.total_quantity = arg0.total_quantity - 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v7 = 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::mint(arg3);
        let v8 = MintChestEvent{
            chest_id : 0x2::object::id<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::SamChest>(&v7),
            sender   : v5,
            code     : arg1,
        };
        0x2::event::emit<MintChestEvent>(v8);
        v7
    }

    entry fun mint_clover(arg0: &mut Mint, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::SamChest>, arg5: &0x2::transfer_policy::TransferPolicy<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::SamChest>(arg2, arg3, arg1, 0);
        let (v0, v1) = 0x2::kiosk::purchase<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::SamChest>(arg2, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v2 = v1;
        let v3 = MINT_RULE{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::SamChest, MINT_RULE>(v3, arg4, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::SamChest>(arg4, v2);
        assert!(arg0.is_mint_clover_open, 3);
        0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest::burn(v0);
        let v7 = 0;
        let v8 = arg0.quantities;
        0x1::vector::reverse<u64>(&mut v8);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v8)) {
            v7 = v7 + 0x1::vector::pop_back<u64>(&mut v8);
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u64>(v8);
        let v10 = 0x1::vector::empty<Threshold>();
        let v11 = 0;
        let v12 = 0;
        let v13 = &arg0.quantities;
        let v14 = 0;
        while (v14 < 0x1::vector::length<u64>(v13)) {
            let v15 = *0x1::vector::borrow<u64>(v13, v14);
            if (v15 > 0) {
                let v16 = v11 + v15;
                v11 = v16;
                let v17 = Threshold{
                    index     : v12,
                    threshold : v16,
                };
                0x1::vector::push_back<Threshold>(&mut v10, v17);
            };
            v12 = v12 + 1;
            v14 = v14 + 1;
        };
        let v18 = 0x2::random::new_generator(arg6, arg7);
        v12 = 0;
        while (0x1::vector::length<Threshold>(&v10) > v12) {
            let v19 = *0x1::vector::borrow<Threshold>(&v10, v12);
            if (v19.threshold >= 0x2::random::generate_u64_in_range(&mut v18, 1, v7)) {
                let v20 = 0x1::vector::borrow_mut<u64>(&mut arg0.quantities, v19.index);
                *v20 = *v20 - 1;
                let v21 = 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::mint(arg7, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::index_to_clover_type(v19.index));
                let v22 = MintCloverEvent{
                    chest_id  : arg1,
                    clover_id : 0x2::object::id<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&v21),
                    sender    : 0x2::tx_context::sender(arg7),
                };
                0x2::event::emit<MintCloverEvent>(v22);
                0x2::kiosk::lock<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(arg2, arg3, arg5, v21);
                break
            };
            v12 = v12 + 1;
        };
    }

    public(friend) fun new_mint(arg0: u64, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Mint{
            id                  : 0x2::object::new(arg4),
            referrals           : 0x2::table::new<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(arg4),
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

    public fun remove_referral(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::burn(0x2::table::remove<0x1::string::String, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::referral::Referral>(&mut arg1.referrals, arg2), arg3);
    }

    public fun total_quantity(arg0: &Mint) : u64 {
        arg0.total_quantity
    }

    // decompiled from Move bytecode v6
}

