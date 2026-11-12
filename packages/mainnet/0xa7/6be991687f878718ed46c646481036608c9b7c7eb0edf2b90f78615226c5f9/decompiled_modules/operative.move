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

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        render_pubkey: vector<u8>,
        pending_image_url: 0x1::string::String,
        categories: vector<0x1::string::String>,
    }

    struct Slot has copy, drop, store {
        category: 0x1::string::String,
    }

    struct Loadout has drop, store {
        traits: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        image_url: 0x1::string::String,
        image_attested: bool,
        revision: u64,
    }

    struct LoadoutChanged has copy, drop {
        operative_id: address,
        revision: u64,
        category: 0x1::string::String,
        trait_id: address,
        equipped: bool,
    }

    struct ImageAttested has copy, drop {
        operative_id: address,
        revision: u64,
        image_url: 0x1::string::String,
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

    public fun admin_set_render_key(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        arg1.render_pubkey = arg2;
    }

    public fun admin_set_version(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.version = arg2;
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

    fun attach(arg0: &Config, arg1: &mut Operative, arg2: Trait, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 100);
        ensure_migrated(arg0, arg1, arg3);
        let v0 = arg2.category;
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.categories, &v0), 101);
        let v1 = Slot{category: v0};
        assert!(!0x2::dynamic_object_field::exists<Slot>(&arg1.id, v1), 102);
        let v2 = Slot{category: v0};
        0x2::dynamic_object_field::add<Slot, Trait>(&mut arg1.id, v2, arg2);
        let v3 = record_mut(arg1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3.traits, v0, arg2.name);
        invalidate(arg0, arg1);
        let v4 = LoadoutChanged{
            operative_id : 0x2::object::uid_to_address(&arg1.id),
            revision     : record(arg1).revision,
            category     : v0,
            trait_id     : 0x2::object::uid_to_address(&arg2.id),
            equipped     : true,
        };
        0x2::event::emit<LoadoutChanged>(v4);
    }

    public fun attach_image(arg0: &Config, arg1: &mut Operative, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 100);
        ensure_migrated(arg0, arg1, arg4);
        attest(arg0, arg1, arg2, arg3);
    }

    fun attest(arg0: &Config, arg1: &mut Operative, arg2: 0x1::string::String, arg3: vector<u8>) {
        let v0 = attestation_message(arg0, &record(arg1).traits, &arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.render_pubkey, &v0), 104);
        let v1 = record_mut(arg1);
        v1.image_url = arg2;
        v1.image_attested = true;
        let v2 = ImageAttested{
            operative_id : 0x2::object::uid_to_address(&arg1.id),
            revision     : record(arg1).revision,
            image_url    : arg2,
        };
        0x2::event::emit<ImageAttested>(v2);
    }

    public fun attestation_message(arg0: &Config, arg1: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg2: &0x1::string::String) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0.categories)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.categories, v1);
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
            let v3 = if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg1, &v2)) {
                *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg1, &v2)
            } else {
                0x1::string::utf8(b"")
            };
            let v4 = v3;
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
            v1 = v1 + 1;
        };
        let v5 = b"NUMBPOLYS_IMAGE_V1";
        0x1::vector::append<u8>(&mut v5, 0x2::hash::blake2b256(&v0));
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<0x1::string::String>(arg2));
        v5
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

    public fun create_config(arg0: &AdminCap, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                : 0x2::object::new(arg4),
            version           : 4,
            render_pubkey     : arg1,
            pending_image_url : arg2,
            categories        : arg3,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun detach(arg0: &Config, arg1: &mut Operative, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) : Trait {
        assert!(arg0.version == 4, 100);
        ensure_migrated(arg0, arg1, arg3);
        let v0 = Slot{category: arg2};
        assert!(0x2::dynamic_object_field::exists<Slot>(&arg1.id, v0), 103);
        let v1 = Slot{category: arg2};
        let v2 = 0x2::dynamic_object_field::remove<Slot, Trait>(&mut arg1.id, v1);
        let v3 = record_mut(arg1);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v3.traits, &arg2);
        invalidate(arg0, arg1);
        let v6 = LoadoutChanged{
            operative_id : 0x2::object::uid_to_address(&arg1.id),
            revision     : record(arg1).revision,
            category     : arg2,
            trait_id     : 0x2::object::uid_to_address(&v2.id),
            equipped     : false,
        };
        0x2::event::emit<LoadoutChanged>(v6);
        v2
    }

    fun ensure_migrated(arg0: &Config, arg1: &mut Operative, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists<0x1::string::String>(&arg1.id, record_key())) {
            let v0 = Loadout{
                traits         : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                image_url      : arg0.pending_image_url,
                image_attested : false,
                revision       : 0,
            };
            0x2::dynamic_field::add<0x1::string::String, Loadout>(&mut arg1.id, record_key(), v0);
        };
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg0.categories)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg0.categories, v2);
            if (0x2::dynamic_object_field::exists_with_type<0x1::string::String, Trait>(&arg1.id, v3)) {
                let v4 = 0x2::dynamic_object_field::remove<0x1::string::String, Trait>(&mut arg1.id, v3);
                let v5 = Slot{category: v3};
                if (0x2::dynamic_object_field::exists<Slot>(&arg1.id, v5)) {
                    0x2::transfer::public_transfer<Trait>(v4, 0x2::tx_context::sender(arg2));
                } else {
                    let v6 = Slot{category: v3};
                    0x2::dynamic_object_field::add<Slot, Trait>(&mut arg1.id, v6, v4);
                    let v7 = record_mut(arg1);
                    0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7.traits, v3, v4.name);
                    v1 = true;
                };
            };
            v2 = v2 + 1;
        };
        if (v1) {
            invalidate(arg0, arg1);
        };
    }

    public fun equip(arg0: &Config, arg1: &mut Operative, arg2: Trait, arg3: &mut 0x2::tx_context::TxContext) {
        attach(arg0, arg1, arg2, arg3);
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

    public fun equip_with_image(arg0: &Config, arg1: &mut Operative, arg2: Trait, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        attach(arg0, arg1, arg2, arg5);
        attest(arg0, arg1, arg3, arg4);
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

    fun invalidate(arg0: &Config, arg1: &mut Operative) {
        let v0 = record_mut(arg1);
        v0.revision = v0.revision + 1;
        v0.image_url = arg0.pending_image_url;
        v0.image_attested = false;
    }

    public fun is_migrated(arg0: &Operative) : bool {
        0x2::dynamic_field::exists<0x1::string::String>(&arg0.id, record_key())
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

    public fun loadout_image_attested(arg0: &Operative) : bool {
        record(arg0).image_attested
    }

    public fun loadout_image_url(arg0: &Operative) : 0x1::string::String {
        record(arg0).image_url
    }

    public fun loadout_revision(arg0: &Operative) : u64 {
        record(arg0).revision
    }

    public fun loadout_traits(arg0: &Operative) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &record(arg0).traits
    }

    public fun migrate(arg0: &Config, arg1: &mut Operative, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 100);
        ensure_migrated(arg0, arg1, arg2);
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

    fun record(arg0: &Operative) : &Loadout {
        0x2::dynamic_field::borrow<0x1::string::String, Loadout>(&arg0.id, record_key())
    }

    fun record_key() : 0x1::string::String {
        0x1::string::utf8(b"loadout")
    }

    fun record_mut(arg0: &mut Operative) : &mut Loadout {
        0x2::dynamic_field::borrow_mut<0x1::string::String, Loadout>(&mut arg0.id, record_key())
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

    public fun unequip(arg0: &Config, arg1: &mut Operative, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Trait>(detach(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
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

    public fun unequip_with_image(arg0: &Config, arg1: &mut Operative, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = detach(arg0, arg1, arg2, arg5);
        attest(arg0, arg1, arg3, arg4);
        0x2::transfer::public_transfer<Trait>(v0, 0x2::tx_context::sender(arg5));
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

