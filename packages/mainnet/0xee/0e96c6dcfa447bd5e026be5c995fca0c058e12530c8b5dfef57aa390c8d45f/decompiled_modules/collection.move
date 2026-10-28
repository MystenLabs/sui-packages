module 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DisplayCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PriceTier has copy, drop, store {
        start_ms: u64,
        price: u64,
    }

    struct Gate has copy, drop, store {
        price: u64,
        start_ms: u64,
        end_ms: u64,
        max_per_wallet: u64,
        open: bool,
    }

    struct GateKey has copy, drop, store {
        gate: 0x1::type_name::TypeName,
        wallet: address,
    }

    struct Pack has copy, drop, store {
        min_count: u64,
        max_unit_price: u64,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        version: u64,
        revision: u64,
        name: 0x1::string::String,
        supply: u64,
        minted: u64,
        public_start_ms: u64,
        mint_open: bool,
        tiers: vector<PriceTier>,
        max_per_tx: u64,
        max_per_wallet: u64,
        minted_by: 0x2::table::Table<address, u64>,
        luck_max: u8,
        packs: vector<Pack>,
        gates: 0x2::table::Table<0x1::type_name::TypeName, Gate>,
        gate_minted: 0x2::table::Table<GateKey, u64>,
        wallet_a: address,
        wallet_b: address,
        bps_a: u64,
        policy: 0x2::object::ID,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Mortem>,
        display: 0x2::object::ID,
        media_base: 0x1::string::String,
        rising: Rising,
        media_frozen: bool,
    }

    struct Rising has store {
        reveal_open: bool,
        reveal_start_ms: u64,
        seeded: u64,
        drawn: u64,
        pool: vector<u16>,
        provenance_hash: vector<u8>,
        provenance_scheme: 0x1::string::String,
        running_hash: vector<u8>,
        seeding_sealed: bool,
    }

    struct Mortem has store, key {
        id: 0x2::object::UID,
        number: u64,
        index: u64,
        name: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        filler: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        metadata_version: u64,
        luck: u8,
        pad: vector<u8>,
    }

    struct CollectionCreated has copy, drop {
        collection: 0x2::object::ID,
        policy: 0x2::object::ID,
        display: 0x2::object::ID,
        supply: u64,
    }

    struct GraveMinted has copy, drop {
        collection: 0x2::object::ID,
        item: 0x2::object::ID,
        number: u64,
        minter: address,
        kiosk: 0x2::object::ID,
        price: u64,
        luck: u8,
    }

    struct PaymentSplit has copy, drop {
        collection: 0x2::object::ID,
        total: u64,
        to_a: u64,
        to_b: u64,
    }

    struct ConfigUpdated has copy, drop {
        collection: 0x2::object::ID,
        revision: u64,
        section: u8,
    }

    struct MintOpenSet has copy, drop {
        collection: 0x2::object::ID,
        open: bool,
    }

    struct SaleSet has copy, drop {
        collection: 0x2::object::ID,
        public_start_ms: u64,
        starts: vector<u64>,
        prices: vector<u64>,
    }

    struct LimitsSet has copy, drop {
        collection: 0x2::object::ID,
        max_per_tx: u64,
        max_per_wallet: u64,
    }

    struct SplitSet has copy, drop {
        collection: 0x2::object::ID,
        wallet_a: address,
        wallet_b: address,
        bps_a: u64,
    }

    struct RoyaltySet has copy, drop {
        collection: 0x2::object::ID,
        bps: u16,
        min: u64,
    }

    struct RoyaltiesDistributed has copy, drop {
        collection: 0x2::object::ID,
        total: u64,
        to_a: u64,
        to_b: u64,
    }

    struct MediaConfigured has copy, drop {
        collection: 0x2::object::ID,
        base: 0x1::string::String,
    }

    struct RevealStartSet has copy, drop {
        collection: 0x2::object::ID,
        reveal_start_ms: u64,
    }

    struct LuckMaxSet has copy, drop {
        collection: 0x2::object::ID,
        luck_max: u8,
    }

    struct GateSet has copy, drop {
        collection: 0x2::object::ID,
        gate: 0x1::type_name::TypeName,
        price: u64,
        start_ms: u64,
        end_ms: u64,
        max_per_wallet: u64,
        open: bool,
    }

    struct PacksSet has copy, drop {
        collection: 0x2::object::ID,
        min_counts: vector<u64>,
        max_unit_prices: vector<u64>,
    }

    struct GateUsed has copy, drop {
        collection: 0x2::object::ID,
        gate: 0x1::type_name::TypeName,
        wallet: address,
        count: u64,
        price: u64,
    }

    struct AdminTransferred has copy, drop {
        collection: 0x2::object::ID,
        to: address,
    }

    struct Migrated has copy, drop {
        collection: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    fun assert_admin(arg0: &AdminCap, arg1: &Collection) {
        assert!(arg0.collection == 0x2::object::id<Collection>(arg1), 109);
    }

    fun bury(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::random::RandomGenerator, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_open, 101);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Mortem>>(arg1) == arg0.policy, 108);
        assert!(arg5 > 0 && arg5 <= arg0.max_per_tx, 104);
        assert!(arg0.minted + arg5 <= arg0.supply, 103);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.minted_by, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.minted_by, v0)
        } else {
            0
        };
        assert!(arg0.max_per_wallet == 0 || v1 + arg5 <= arg0.max_per_wallet, 105);
        assert!(arg6 <= arg7, 106);
        let v2 = arg6 * arg5;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2, 107);
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2, arg9);
        let (v4, v5) = settle(arg0, v3, arg9);
        let v6 = PaymentSplit{
            collection : 0x2::object::id<Collection>(arg0),
            total      : v2,
            to_a       : v4,
            to_b       : v5,
        };
        0x2::event::emit<PaymentSplit>(v6);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        if (0x2::table::contains<address, u64>(&arg0.minted_by, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.minted_by, v0) = v1 + arg5;
        } else {
            0x2::table::add<address, u64>(&mut arg0.minted_by, v0, arg5);
        };
        let v7 = 0;
        while (v7 < arg5) {
            0x2::kiosk::lock<Mortem>(arg2, arg3, arg1, forge_grave(arg0, v0, 0x2::object::id<0x2::kiosk::Kiosk>(arg2), arg6, arg8, arg9));
            v7 = v7 + 1;
        };
    }

    fun changed(arg0: &mut Collection, arg1: u8) {
        arg0.revision = arg0.revision + 1;
        let v0 = ConfigUpdated{
            collection : 0x2::object::id<Collection>(arg0),
            revision   : arg0.revision,
            section    : arg1,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun check_admin(arg0: &AdminCap, arg1: &Collection) {
        assert_admin(arg0, arg1);
        check_version(arg1);
    }

    public(friend) fun check_current(arg0: &Collection) {
        check_version(arg0);
    }

    fun check_version(arg0: &Collection) {
        assert!(arg0.version == 1, 100);
    }

    public(friend) fun collection_uid(arg0: &Collection) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun collection_uid_mut(arg0: &mut Collection) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    entry fun configure_media(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::display::Display<Mortem>, arg3: 0x1::string::String) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        assert!(!has_display_v2(arg1), 114);
        configure_media_internal(arg1, arg2, arg3);
    }

    entry fun configure_media_and_sync(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::display::Display<Mortem>, arg3: &mut 0x2::display_registry::Display<Mortem>, arg4: 0x1::string::String) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        assert!(has_display_v2(arg1), 114);
        configure_media_internal(arg1, arg2, arg4);
        rebuild_v2(arg1, arg2, arg3, 0x1::option::some<0x1::string::String>(media_url(arg1.media_base, b"tokens/0.webp")));
    }

    fun configure_media_internal(arg0: &mut Collection, arg1: &mut 0x2::display::Display<Mortem>, arg2: 0x1::string::String) {
        assert!(!arg0.media_frozen, 120);
        assert!(0x2::object::id<0x2::display::Display<Mortem>>(arg1) == arg0.display, 116);
        assert!(valid_base(&arg2), 120);
        let v0 = media_url(arg2, b"tokens/{index}.webp");
        0x2::display::edit<Mortem>(arg1, 0x1::string::utf8(b"image_url"), v0);
        0x2::display::edit<Mortem>(arg1, 0x1::string::utf8(b"thumbnail_url"), v0);
        0x2::display::update_version<Mortem>(arg1);
        arg0.media_base = arg2;
        changed(arg0, 5);
        let v1 = MediaConfigured{
            collection : 0x2::object::id<Collection>(arg0),
            base       : arg2,
        };
        0x2::event::emit<MediaConfigured>(v1);
    }

    fun copy_v1(arg0: &0x2::display::Display<Mortem>, arg1: &mut 0x2::display_registry::Display<Mortem>, arg2: &0x2::display_registry::DisplayCap<Mortem>) {
        let v0 = 0x2::display::fields<Mortem>(arg0);
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(v0)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(v0, v1);
            0x2::display_registry::set<Mortem>(arg1, arg2, *v2, *v3);
            v1 = v1 + 1;
        };
    }

    entry fun create_display_v2(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &0x2::display::Display<Mortem>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        let v0 = 0x2::object::id<0x2::display_registry::DisplayRegistry>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0xd, 115);
        assert!(!has_display_v2(arg1), 115);
        assert!(0x2::object::id<0x2::display::Display<Mortem>>(arg3) == arg1.display, 116);
        assert!(media_ready(arg1), 112);
        let (v1, v2) = 0x2::display_registry::new<Mortem>(arg2, 0x1::internal::permit<Mortem>(), arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        copy_v1(arg3, v5, &v3);
        let (v6, v7) = v2_extras(arg1);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::string::String>(&v9)) {
            0x2::display_registry::set<Mortem>(&mut v4, &v3, *0x1::vector::borrow<0x1::string::String>(&v9, v10), *0x1::vector::borrow<0x1::string::String>(&v8, v10));
            v10 = v10 + 1;
        };
        0x2::display_registry::share<Mortem>(v4);
        let v11 = DisplayCapKey{dummy_field: false};
        0x2::dynamic_field::add<DisplayCapKey, 0x2::display_registry::DisplayCap<Mortem>>(&mut arg1.id, v11, v3);
        changed(arg1, 6);
    }

    entry fun distribute(arg0: &Collection, arg1: &mut 0x2::transfer_policy::TransferPolicy<Mortem>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Mortem>>(arg1) == arg0.policy, 108);
        let v0 = 0x2::transfer_policy::withdraw<Mortem>(arg1, &arg0.policy_cap, 0x1::option::none<u64>(), arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 > 0, 117);
        let (v2, v3) = settle(arg0, v0, arg2);
        let v4 = RoyaltiesDistributed{
            collection : 0x2::object::id<Collection>(arg0),
            total      : v1,
            to_a       : v2,
            to_b       : v3,
        };
        0x2::event::emit<RoyaltiesDistributed>(v4);
    }

    fun draw_luck(arg0: &mut 0x2::random::RandomGenerator, arg1: u8) : u8 {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(arg0, 0, arg1);
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    fun enter_gate<T0>(arg0: &mut Collection, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        check_version(arg0);
        assert!(arg0.mint_open, 101);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Gate>(&arg0.gates, v0), 122);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, Gate>(&arg0.gates, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = if (v1.open) {
            if (v2 >= v1.start_ms) {
                v2 < v1.end_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 123);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = GateKey{
            gate   : v0,
            wallet : v4,
        };
        let v6 = if (0x2::table::contains<GateKey, u64>(&arg0.gate_minted, v5)) {
            *0x2::table::borrow<GateKey, u64>(&arg0.gate_minted, v5)
        } else {
            0
        };
        assert!(v1.max_per_wallet == 0 || v6 + arg1 <= v1.max_per_wallet, 125);
        if (0x2::table::contains<GateKey, u64>(&arg0.gate_minted, v5)) {
            *0x2::table::borrow_mut<GateKey, u64>(&mut arg0.gate_minted, v5) = v6 + arg1;
        } else {
            0x2::table::add<GateKey, u64>(&mut arg0.gate_minted, v5, arg1);
        };
        let v7 = GateUsed{
            collection : 0x2::object::id<Collection>(arg0),
            gate       : v0,
            wallet     : v4,
            count      : arg1,
            price      : v1.price,
        };
        0x2::event::emit<GateUsed>(v7);
        v1.price
    }

    fun forge_grave(arg0: &mut Collection, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::random::RandomGenerator, arg5: &mut 0x2::tx_context::TxContext) : Mortem {
        assert!(arg0.minted < arg0.supply, 103);
        arg0.minted = arg0.minted + 1;
        let v0 = draw_luck(arg4, arg0.luck_max);
        let v1 = 0x2::object::new(arg5);
        let v2 = GraveMinted{
            collection : 0x2::object::id<Collection>(arg0),
            item       : 0x2::object::uid_to_inner(&v1),
            number     : arg0.minted,
            minter     : arg1,
            kiosk      : arg2,
            price      : arg3,
            luck       : v0,
        };
        0x2::event::emit<GraveMinted>(v2);
        let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"Luck"), luck_label(v0));
        Mortem{
            id               : v1,
            number           : arg0.minted,
            index            : 0,
            name             : 0x1::string::utf8(b"MORTEM Grave"),
            attributes       : v3,
            filler           : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            metadata_version : 0,
            luck             : v0,
            pad              : b"",
        }
    }

    entry fun gate_mint_in_kiosk<T0: store + key>(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg9, arg10);
        assert!(0x2::kiosk::has_access(arg2, &arg3) && 0x2::kiosk::has_item_with_type<T0>(arg2, arg4), 124);
        let v1 = enter_gate<T0>(arg0, arg6, arg8, arg10);
        let v2 = &mut v0;
        bury(arg0, arg1, arg2, &arg3, arg5, arg6, v1, arg7, v2, arg10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg3, 0x2::tx_context::sender(arg10));
    }

    entry fun gate_mint_in_personal_kiosk<T0: store + key>(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg9, arg10);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg3);
        let v3 = v1;
        assert!(0x2::kiosk::has_access(arg2, &v3) && 0x2::kiosk::has_item_with_type<T0>(arg2, arg4), 124);
        let v4 = enter_gate<T0>(arg0, arg6, arg8, arg10);
        let v5 = &mut v0;
        bury(arg0, arg1, arg2, &v3, arg5, arg6, v4, arg7, v5, arg10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg3, v3, v2);
    }

    entry fun gate_mint_owned_to_kiosk<T0: store + key>(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: T0, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg9, arg10);
        let v1 = enter_gate<T0>(arg0, arg6, arg8, arg10);
        let v2 = &mut v0;
        bury(arg0, arg1, arg3, arg4, arg5, arg6, v1, arg7, v2, arg10);
        0x2::transfer::public_transfer<T0>(arg2, 0x2::tx_context::sender(arg10));
    }

    entry fun gate_mint_owned_to_new_kiosk<T0: store + key>(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg7, arg8);
        let v1 = enter_gate<T0>(arg0, arg4, arg6, arg8);
        let (v2, v3) = 0x2::kiosk::new(arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = &mut v5;
        let v7 = &mut v0;
        bury(arg0, arg1, v6, &v4, arg3, arg4, v1, arg5, v7, arg8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<T0>(arg2, 0x2::tx_context::sender(arg8));
    }

    entry fun gate_mint_owned_to_personal_kiosk<T0: store + key>(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: T0, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg9, arg10);
        let v1 = enter_gate<T0>(arg0, arg6, arg8, arg10);
        let (v2, v3) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg4);
        let v4 = v2;
        let v5 = &mut v0;
        bury(arg0, arg1, arg3, &v4, arg5, arg6, v1, arg7, v5, arg10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg4, v4, v3);
        0x2::transfer::public_transfer<T0>(arg2, 0x2::tx_context::sender(arg10));
    }

    public(friend) fun grave_uid(arg0: &Mortem) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun grave_uid_mut(arg0: &mut Mortem) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun has_display_v2(arg0: &Collection) : bool {
        let v0 = DisplayCapKey{dummy_field: false};
        0x2::dynamic_field::exists<DisplayCapKey>(&arg0.id, v0)
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = media_url(0x1::string::utf8(b"https://media.mortem.invalid/"), b"tokens/{index}.webp");
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name} #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A sealed MORTEM grave. Something waits under the stone. On the night of the Rising it cracks open and gives back a hand-drawn pixel skull; the luck carved on it may call a rarer one."));
        0x1::vector::push_back<0x1::string::String>(v4, v2);
        0x1::vector::push_back<0x1::string::String>(v4, v2);
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://mortem.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"PulseSinister & Sudcero"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{number}"));
        let v5 = 0x2::display::new_with_fields<Mortem>(&v1, v1_keys(), v3, arg1);
        0x2::display::update_version<Mortem>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Mortem>(&v1, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Mortem>(&mut v9, &v8, 300, 50000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Mortem>(&mut v9, &v8);
        let v10 = 0x2::object::new(arg1);
        let v11 = 0x2::object::uid_to_inner(&v10);
        let v12 = PublisherKey{dummy_field: false};
        0x2::dynamic_field::add<PublisherKey, 0x2::package::Publisher>(&mut v10, v12, v1);
        let v13 = Rising{
            reveal_open       : false,
            reveal_start_ms   : 18446744073709551615,
            seeded            : 0,
            drawn             : 0,
            pool              : vector[],
            provenance_hash   : b"",
            provenance_scheme : 0x1::string::utf8(b""),
            running_hash      : b"",
            seeding_sealed    : false,
        };
        let v14 = Collection{
            id              : v10,
            version         : 1,
            revision        : 0,
            name            : 0x1::string::utf8(b"MORTEM"),
            supply          : 666,
            minted          : 0,
            public_start_ms : 18446744073709551615,
            mint_open       : false,
            tiers           : 0x1::vector::empty<PriceTier>(),
            max_per_tx      : 10,
            max_per_wallet  : 5,
            minted_by       : 0x2::table::new<address, u64>(arg1),
            luck_max        : 13,
            packs           : 0x1::vector::empty<Pack>(),
            gates           : 0x2::table::new<0x1::type_name::TypeName, Gate>(arg1),
            gate_minted     : 0x2::table::new<GateKey, u64>(arg1),
            wallet_a        : @0x0,
            wallet_b        : @0x0,
            bps_a           : 10000,
            policy          : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Mortem>>(&v9),
            policy_cap      : v8,
            display         : 0x2::object::id<0x2::display::Display<Mortem>>(&v5),
            media_base      : 0x1::string::utf8(b"https://media.mortem.invalid/"),
            rising          : v13,
            media_frozen    : false,
        };
        let v15 = CollectionCreated{
            collection : v11,
            policy     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Mortem>>(&v9),
            display    : 0x2::object::id<0x2::display::Display<Mortem>>(&v5),
            supply     : 666,
        };
        0x2::event::emit<CollectionCreated>(v15);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Mortem>>(v9);
        0x2::transfer::share_object<Collection>(v14);
        0x2::transfer::public_transfer<0x2::display::Display<Mortem>>(v5, v0);
        let v16 = AdminCap{
            id         : 0x2::object::new(arg1),
            collection : v11,
        };
        0x2::transfer::transfer<AdminCap>(v16, v0);
    }

    fun luck_label(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::u8::to_string(arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%"));
        v0
    }

    fun media_ready(arg0: &Collection) : bool {
        valid_base(&arg0.media_base)
    }

    fun media_url(arg0: 0x1::string::String, arg1: vector<u8>) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(arg1));
        arg0
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Collection) {
        assert_admin(arg0, arg1);
        assert!(arg1.version < 1, 118);
        let v0 = Migrated{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.version,
            to         : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    fun mint_graves(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::random::RandomGenerator, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.mint_open, 101);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg0.public_start_ms, 102);
        let v1 = unit_price(arg0, price_at(arg0, v0), arg5);
        bury(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg6, arg8, arg9);
    }

    public fun mint_open(arg0: &Collection) : bool {
        arg0.mint_open
    }

    entry fun mint_to_kiosk(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg8, arg9);
        let v1 = &mut v0;
        mint_graves(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, arg9);
    }

    entry fun mint_to_new_kiosk(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg6, arg7);
        let (v1, v2) = 0x2::kiosk::new(arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = &mut v0;
        mint_graves(arg0, arg1, v5, &v3, arg2, arg3, arg4, arg5, v6, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg7));
    }

    entry fun mint_to_personal_kiosk(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<Mortem>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg8, arg9);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg3);
        let v3 = v1;
        let v4 = &mut v0;
        mint_graves(arg0, arg1, arg2, &v3, arg4, arg5, arg6, arg7, v4, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg3, v3, v2);
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun minted_by(arg0: &Collection, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.minted_by, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.minted_by, arg1)
        } else {
            0
        }
    }

    fun price_at(arg0: &Collection, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<PriceTier>(&arg0.tiers);
        assert!(v0 > 0, 112);
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<PriceTier>(&arg0.tiers, v3);
            if (v4.start_ms <= arg1) {
                v1 = v4.price;
                v2 = true;
            };
            v3 = v3 + 1;
        };
        assert!(v2, 102);
        v1
    }

    public fun price_for(arg0: &Collection, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        unit_price(arg0, price_at(arg0, 0x2::clock::timestamp_ms(arg1)), arg2)
    }

    public fun price_now(arg0: &Collection, arg1: &0x2::clock::Clock) : u64 {
        price_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun public_start_ms(arg0: &Collection) : u64 {
        arg0.public_start_ms
    }

    fun rebuild_v2(arg0: &Collection, arg1: &0x2::display::Display<Mortem>, arg2: &mut 0x2::display_registry::Display<Mortem>, arg3: 0x1::option::Option<0x1::string::String>) {
        assert!(0x2::object::id<0x2::display::Display<Mortem>>(arg1) == arg0.display, 116);
        assert!(has_display_v2(arg0), 114);
        let v0 = DisplayCapKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DisplayCapKey, 0x2::display_registry::DisplayCap<Mortem>>(&arg0.id, v0);
        assert!(0x2::display_registry::cap_id<Mortem>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::display_registry::DisplayCap<Mortem>>(v1)), 115);
        let v2 = *0x2::display_registry::fields<Mortem>(arg2);
        copy_v1(arg1, arg2, v1);
        let v3 = 0;
        while (v3 < 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&v2)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(&v2, v3);
            if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<Mortem>(arg1), v4)) {
                let v6 = if (*v4 == 0x1::string::utf8(b"collection_cover_url") && 0x1::option::is_some<0x1::string::String>(&arg3)) {
                    *0x1::option::borrow<0x1::string::String>(&arg3)
                } else {
                    *v5
                };
                0x2::display_registry::set<Mortem>(arg2, v1, *v4, v6);
            };
            v3 = v3 + 1;
        };
    }

    entry fun set_gate<T0: key>(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        assert!(arg2 > 0 && arg3 < arg4, 126);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = Gate{
            price          : arg2,
            start_ms       : arg3,
            end_ms         : arg4,
            max_per_wallet : arg5,
            open           : arg6,
        };
        if (0x2::table::contains<0x1::type_name::TypeName, Gate>(&arg1.gates, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, Gate>(&mut arg1.gates, v0) = v1;
        } else {
            0x2::table::add<0x1::type_name::TypeName, Gate>(&mut arg1.gates, v0, v1);
        };
        changed(arg1, 10);
        let v2 = GateSet{
            collection     : 0x2::object::id<Collection>(arg1),
            gate           : v0,
            price          : arg2,
            start_ms       : arg3,
            end_ms         : arg4,
            max_per_wallet : arg5,
            open           : arg6,
        };
        0x2::event::emit<GateSet>(v2);
    }

    entry fun set_limits(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: u64) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        assert!(arg2 > 0 && arg2 <= 50, 119);
        arg1.max_per_tx = arg2;
        arg1.max_per_wallet = arg3;
        changed(arg1, 2);
        let v0 = LimitsSet{
            collection     : 0x2::object::id<Collection>(arg1),
            max_per_tx     : arg2,
            max_per_wallet : arg3,
        };
        0x2::event::emit<LimitsSet>(v0);
    }

    entry fun set_luck_max(arg0: &AdminCap, arg1: &mut Collection, arg2: u8) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        assert!(!arg1.mint_open && arg2 <= 50, 121);
        arg1.luck_max = arg2;
        changed(arg1, 9);
        let v0 = LuckMaxSet{
            collection : 0x2::object::id<Collection>(arg1),
            luck_max   : arg2,
        };
        0x2::event::emit<LuckMaxSet>(v0);
    }

    entry fun set_mint_open(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        if (arg2) {
            let v0 = if (arg1.wallet_a != @0x0) {
                if (arg1.wallet_b != @0x0) {
                    arg1.bps_a <= 10000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 112);
            assert!(0x1::vector::length<PriceTier>(&arg1.tiers) > 0 && arg1.public_start_ms != 18446744073709551615, 110);
            assert!(0x1::vector::borrow<PriceTier>(&arg1.tiers, 0).start_ms == arg1.public_start_ms, 110);
            assert!(media_ready(arg1), 120);
            assert!(has_display_v2(arg1), 114);
        };
        arg1.mint_open = arg2;
        changed(arg1, 8);
        let v1 = MintOpenSet{
            collection : 0x2::object::id<Collection>(arg1),
            open       : arg2,
        };
        0x2::event::emit<MintOpenSet>(v1);
    }

    entry fun set_packs(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u64>, arg3: vector<u64>) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 110);
        let v1 = 0x1::vector::empty<Pack>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = if (*0x1::vector::borrow<u64>(&arg2, v2) > 1) {
                if (*0x1::vector::borrow<u64>(&arg2, v2) <= arg1.max_per_tx) {
                    *0x1::vector::borrow<u64>(&arg3, v2) > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 110);
            if (v2 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg2, v2) > *0x1::vector::borrow<u64>(&arg2, v2 - 1), 110);
            };
            let v4 = Pack{
                min_count      : *0x1::vector::borrow<u64>(&arg2, v2),
                max_unit_price : *0x1::vector::borrow<u64>(&arg3, v2),
            };
            0x1::vector::push_back<Pack>(&mut v1, v4);
            v2 = v2 + 1;
        };
        arg1.packs = v1;
        changed(arg1, 11);
        let v5 = PacksSet{
            collection      : 0x2::object::id<Collection>(arg1),
            min_counts      : arg2,
            max_unit_prices : arg3,
        };
        0x2::event::emit<PacksSet>(v5);
    }

    entry fun set_reveal_start(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        arg1.rising.reveal_start_ms = arg2;
        changed(arg1, 7);
        let v0 = RevealStartSet{
            collection      : 0x2::object::id<Collection>(arg1),
            reveal_start_ms : arg2,
        };
        0x2::event::emit<RevealStartSet>(v0);
    }

    entry fun set_royalty(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::transfer_policy::TransferPolicy<Mortem>, arg3: u16, arg4: u64) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Mortem>>(arg2) == arg1.policy, 108);
        assert!(arg3 > 0 && arg3 <= 1000, 113);
        0x2::transfer_policy::remove_rule<Mortem, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Config>(arg2, &arg1.policy_cap);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Mortem>(arg2, &arg1.policy_cap, arg3, arg4);
        changed(arg1, 4);
        let v0 = RoyaltySet{
            collection : 0x2::object::id<Collection>(arg1),
            bps        : arg3,
            min        : arg4,
        };
        0x2::event::emit<RoyaltySet>(v0);
    }

    entry fun set_sale(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<u64>, arg4: vector<u64>) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 > 0 && v0 == 0x1::vector::length<u64>(&arg4), 110);
        assert!(*0x1::vector::borrow<u64>(&arg3, 0) == arg2 && arg2 != 18446744073709551615, 110);
        let v1 = 0x1::vector::empty<PriceTier>();
        let v2 = 0;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg4, v2) > 0, 110);
            if (v2 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg3, v2) > *0x1::vector::borrow<u64>(&arg3, v2 - 1), 110);
            };
            let v3 = PriceTier{
                start_ms : *0x1::vector::borrow<u64>(&arg3, v2),
                price    : *0x1::vector::borrow<u64>(&arg4, v2),
            };
            0x1::vector::push_back<PriceTier>(&mut v1, v3);
            v2 = v2 + 1;
        };
        arg1.tiers = v1;
        arg1.public_start_ms = arg2;
        changed(arg1, 1);
        let v4 = SaleSet{
            collection      : 0x2::object::id<Collection>(arg1),
            public_start_ms : arg2,
            starts          : arg3,
            prices          : arg4,
        };
        0x2::event::emit<SaleSet>(v4);
    }

    entry fun set_split(arg0: &AdminCap, arg1: &mut Collection, arg2: address, arg3: address, arg4: u64) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        let v0 = if (arg2 != @0x0) {
            if (arg3 != @0x0) {
                arg4 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 111);
        arg1.wallet_a = arg2;
        arg1.wallet_b = arg3;
        arg1.bps_a = arg4;
        changed(arg1, 3);
        let v1 = SplitSet{
            collection : 0x2::object::id<Collection>(arg1),
            wallet_a   : arg2,
            wallet_b   : arg3,
            bps_a      : arg4,
        };
        0x2::event::emit<SplitSet>(v1);
    }

    fun settle(arg0: &Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg0.wallet_a != @0x0 && arg0.wallet_b != @0x0, 112);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = (((v0 as u128) * ((10000 - arg0.bps_a) as u128) / (10000 as u128)) as u64);
        let v2 = v0 - v1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg2), arg0.wallet_b);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.wallet_a);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        (v2, v1)
    }

    public fun supply(arg0: &Collection) : u64 {
        arg0.supply
    }

    entry fun sync_display_v2(arg0: &AdminCap, arg1: &Collection, arg2: &0x2::display::Display<Mortem>, arg3: &mut 0x2::display_registry::Display<Mortem>) {
        assert_admin(arg0, arg1);
        check_version(arg1);
        rebuild_v2(arg1, arg2, arg3, 0x1::option::none<0x1::string::String>());
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        let v0 = AdminTransferred{
            collection : arg0.collection,
            to         : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    fun unit_price(arg0: &Collection, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Pack>(&arg0.packs)) {
            let v2 = 0x1::vector::borrow<Pack>(&arg0.packs, v1);
            if (arg2 >= v2.min_count && v2.max_unit_price < v0) {
                v0 = v2.max_unit_price;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun v1_keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"number"));
        v0
    }

    fun v2_extras(arg0: &Collection) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::string::utf8(b"0x");
        let v1 = 0x2::object::id<Collection>(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&v1)));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_cover_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_id"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes:json}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{index}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"MORTEM"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"666 graves on Sui. You don't buy a skull, you buy a grave: on the night of the Rising every stone cracks open and gives back a hand-drawn pixel skull by PulseSinister."));
        0x1::vector::push_back<0x1::string::String>(v5, media_url(arg0.media_base, b"tokens/0.webp"));
        0x1::vector::push_back<0x1::string::String>(v5, v0);
        (v2, v4)
    }

    fun valid_base(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"https://";
        if (0x1::vector::length<u8>(v0) <= 0x1::vector::length<u8>(&v1) + 1 || *0x1::vector::borrow<u8>(v0, 0x1::vector::length<u8>(v0) - 1) != 47) {
            return false
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            if (*0x1::vector::borrow<u8>(v0, v2) != *0x1::vector::borrow<u8>(&v1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        let v3 = 0x1::string::utf8(b".invalid");
        0x1::string::index_of(arg0, &v3) == 0x1::vector::length<u8>(v0)
    }

    // decompiled from Move bytecode v7
}

