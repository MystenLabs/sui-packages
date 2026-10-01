module 0x707cb9b591cce322a918d766879ad599f2875b6062c43ea3c2f16cf30dff6247::operative {
    struct OPERATIVE has drop {
        dummy_field: bool,
    }

    struct Operative has store, key {
        id: 0x2::object::UID,
        mint_id: u64,
        lore_name: 0x1::string::String,
        rarity_tier: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Trait has store, key {
        id: 0x2::object::UID,
        category: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WhitelistTicket has store, key {
        id: 0x2::object::UID,
    }

    struct GtdTicket has store, key {
        id: 0x2::object::UID,
    }

    struct FcfsTicket has store, key {
        id: 0x2::object::UID,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        admin_minted: u64,
        public_minted: u64,
        mint_price: u64,
        phase: u8,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct V3State has key {
        id: 0x2::object::UID,
        royalty_recipient: address,
        royalty_bps: u64,
        royalty_mode: u8,
        gtd_price: u64,
        fcfs_price: u64,
        staking_active: bool,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        operative_id: address,
        staker: address,
        stake_timestamp: u64,
    }

    struct OperativeMinted has copy, drop {
        object_id: address,
        mint_id: u64,
        minter: address,
    }

    struct TraitEquipped has copy, drop {
        operative_id: address,
        trait_id: address,
        category: 0x1::string::String,
    }

    struct TraitUnequipped has copy, drop {
        operative_id: address,
        trait_id: address,
        category: 0x1::string::String,
    }

    struct MetadataSynced has copy, drop {
        operative_id: address,
        new_lore_name: 0x1::string::String,
        new_image_url: 0x1::string::String,
    }

    struct RoyaltyConfigUpdated has copy, drop {
        recipient: address,
        bps: u64,
        mode: u8,
    }

    public fun admin_burn_reserve(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: Operative, arg3: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg3, v0);
            if (0x2::dynamic_object_field::exists<0x1::string::String>(&arg2.id, v1)) {
                let Trait {
                    id        : v2,
                    category  : _,
                    name      : _,
                    image_url : _,
                } = 0x2::dynamic_object_field::remove<0x1::string::String, Trait>(&mut arg2.id, v1);
                0x2::object::delete(v2);
            };
            v0 = v0 + 1;
        };
        let Operative {
            id          : v6,
            mint_id     : _,
            lore_name   : _,
            rarity_tier : _,
            image_url   : _,
        } = arg2;
        0x2::object::delete(v6);
        arg1.admin_minted = arg1.admin_minted - 1;
    }

    public fun admin_mint_standalone_trait(arg0: &AdminCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Trait{
            id        : 0x2::object::new(arg5),
            category  : arg2,
            name      : arg3,
            image_url : arg4,
        };
        0x2::transfer::public_transfer<Trait>(v0, arg1);
    }

    public fun admin_update_operative_metadata(arg0: &AdminCap, arg1: &mut Operative, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg1.lore_name = arg2;
        arg1.image_url = arg3;
    }

    public fun admin_update_trait_image(arg0: &AdminCap, arg1: &mut Operative, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Trait>(&mut arg1.id, arg2).image_url = arg3;
    }

    public fun admin_update_v3_state(arg0: &AdminCap, arg1: &mut V3State, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: address) {
        arg1.gtd_price = arg2;
        arg1.fcfs_price = arg3;
        arg1.royalty_bps = arg4;
        arg1.royalty_mode = arg5;
        arg1.royalty_recipient = arg6;
        let v0 = RoyaltyConfigUpdated{
            recipient : arg6,
            bps       : arg4,
            mode      : arg5,
        };
        0x2::event::emit<RoyaltyConfigUpdated>(v0);
    }

    public fun batch_issue_fcfs(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = FcfsTicket{id: 0x2::object::new(arg2)};
            0x2::transfer::public_transfer<FcfsTicket>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    public fun batch_issue_gtd(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = GtdTicket{id: 0x2::object::new(arg2)};
            0x2::transfer::public_transfer<GtdTicket>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    public fun claim_reserve(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_minted < 111, 1);
        arg1.admin_minted = arg1.admin_minted + 1;
        construct_and_deliver_operative(arg1.admin_minted, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun construct_and_deliver_operative(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Operative{
            id          : 0x2::object::new(arg7),
            mint_id     : arg0,
            lore_name   : arg1,
            rarity_tier : arg2,
            image_url   : arg3,
        };
        let v1 = 0x2::tx_context::sender(arg7);
        0x2::dynamic_field::add<0x1::string::String, address>(&mut v0.id, 0x1::string::utf8(b"original_minter"), v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg4, v2);
            let v4 = Trait{
                id        : 0x2::object::new(arg7),
                category  : v3,
                name      : *0x1::vector::borrow<0x1::string::String>(&arg5, v2),
                image_url : *0x1::vector::borrow<0x1::string::String>(&arg6, v2),
            };
            0x2::dynamic_object_field::add<0x1::string::String, Trait>(&mut v0.id, v3, v4);
            v2 = v2 + 1;
        };
        let v5 = OperativeMinted{
            object_id : 0x2::object::uid_to_address(&v0.id),
            mint_id   : arg0,
            minter    : v1,
        };
        0x2::event::emit<OperativeMinted>(v5);
        0x2::transfer::public_transfer<Operative>(v0, v1);
    }

    public fun equip_trait(arg0: &mut Operative, arg1: Trait, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.category;
        assert!(!0x2::dynamic_object_field::exists<0x1::string::String>(&arg0.id, v0), 7);
        let v1 = TraitEquipped{
            operative_id : 0x2::object::uid_to_address(&arg0.id),
            trait_id     : 0x2::object::uid_to_address(&arg1.id),
            category     : v0,
        };
        0x2::event::emit<TraitEquipped>(v1);
        0x2::dynamic_object_field::add<0x1::string::String, Trait>(&mut arg0.id, v0, arg1);
    }

    public fun fcfs_mint(arg0: &mut MintRegistry, arg1: &V3State, arg2: FcfsTicket, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 2, 4);
        let FcfsTicket { id: v0 } = arg2;
        0x2::object::delete(v0);
        process_payment(arg0, arg3, arg1.fcfs_price, arg10);
        arg0.public_minted = arg0.public_minted + 1;
        construct_and_deliver_operative(arg0.public_minted, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun gtd_mint(arg0: &mut MintRegistry, arg1: &V3State, arg2: GtdTicket, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 1, 3);
        let GtdTicket { id: v0 } = arg2;
        0x2::object::delete(v0);
        process_payment(arg0, arg3, arg1.gtd_price, arg10);
        arg0.public_minted = arg0.public_minted + 1;
        construct_and_deliver_operative(arg0.public_minted, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun init(arg0: OPERATIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OPERATIVE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{lore_name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Numb Polys: A decentralized syndicate of 1,111 operatives secured on the Walrus Mainnet."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://numbpolys.wal.app"));
        let v5 = 0x2::display::new_with_fields<Operative>(&v0, v1, v3, arg1);
        0x2::display::update_version<Operative>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"category"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"A dynamic, standalone trait for the Numb Polys ecosystem."));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{category}"));
        let v10 = 0x2::display::new_with_fields<Trait>(&v0, v6, v8, arg1);
        0x2::display::update_version<Trait>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<Operative>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Trait>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v11 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v11, 0x2::tx_context::sender(arg1));
        let v12 = MintRegistry{
            id            : 0x2::object::new(arg1),
            admin_minted  : 0,
            public_minted : 111,
            mint_price    : 5000000000,
            phase         : 0,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MintRegistry>(v12);
    }

    public fun initialize_v3(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = V3State{
            id                : 0x2::object::new(arg1),
            royalty_recipient : 0x2::tx_context::sender(arg1),
            royalty_bps       : 500,
            royalty_mode      : 0,
            gtd_price         : 2500000000,
            fcfs_price        : 3500000000,
            staking_active    : false,
        };
        0x2::transfer::share_object<V3State>(v0);
    }

    public fun issue_fcfs_ticket(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FcfsTicket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<FcfsTicket>(v0, arg1);
    }

    public fun issue_gtd_ticket(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GtdTicket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<GtdTicket>(v0, arg1);
    }

    public fun issue_whitelist_ticket(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistTicket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<WhitelistTicket>(v0, arg1);
    }

    fun process_payment(arg0: &mut MintRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 6);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg2));
        if (0x2::balance::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public fun public_mint(arg0: &mut MintRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 3, 5);
        assert!(arg0.public_minted < 1111, 2);
        let v0 = arg0.mint_price;
        process_payment(arg0, arg1, v0, arg8);
        arg0.public_minted = arg0.public_minted + 1;
        construct_and_deliver_operative(arg0.public_minted, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun stake_operative(arg0: &mut V3State, arg1: Operative, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.staking_active, 9);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        0x2::dynamic_object_field::add<address, Operative>(&mut arg0.id, v0, arg1);
        let v1 = StakeReceipt{
            id              : 0x2::object::new(arg3),
            operative_id    : v0,
            staker          : 0x2::tx_context::sender(arg3),
            stake_timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::public_transfer<StakeReceipt>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun sync_metadata(arg0: &mut Operative, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.lore_name = arg1;
        arg0.image_url = arg2;
        let v0 = MetadataSynced{
            operative_id  : 0x2::object::uid_to_address(&arg0.id),
            new_lore_name : arg1,
            new_image_url : arg2,
        };
        0x2::event::emit<MetadataSynced>(v0);
    }

    public fun toggle_staking(arg0: &AdminCap, arg1: &mut V3State, arg2: bool) {
        arg1.staking_active = arg2;
    }

    public fun unequip_trait(arg0: &mut Operative, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists<0x1::string::String>(&arg0.id, arg1), 8);
        let v0 = 0x2::dynamic_object_field::remove<0x1::string::String, Trait>(&mut arg0.id, arg1);
        let v1 = TraitUnequipped{
            operative_id : 0x2::object::uid_to_address(&arg0.id),
            trait_id     : 0x2::object::uid_to_address(&v0.id),
            category     : arg1,
        };
        0x2::event::emit<TraitUnequipped>(v1);
        0x2::transfer::public_transfer<Trait>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun unstake_operative(arg0: &mut V3State, arg1: StakeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let StakeReceipt {
            id              : v0,
            operative_id    : v1,
            staker          : v2,
            stake_timestamp : _,
        } = arg1;
        assert!(v2 == 0x2::tx_context::sender(arg2), 10);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<Operative>(0x2::dynamic_object_field::remove<address, Operative>(&mut arg0.id, v1), v2);
    }

    public fun update_phase(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: u8) {
        arg1.phase = arg2;
    }

    public fun update_price(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: u64) {
        arg1.mint_price = arg2;
    }

    public fun update_public_price(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: u64) {
        arg1.mint_price = arg2;
    }

    public fun whitelist_mint(arg0: &mut MintRegistry, arg1: WhitelistTicket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 1 || arg0.phase == 2, 3);
        let WhitelistTicket { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = arg0.mint_price;
        process_payment(arg0, arg2, v1, arg9);
        arg0.public_minted = arg0.public_minted + 1;
        construct_and_deliver_operative(arg0.public_minted, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun withdraw_funds(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

