module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato {
    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        minter: address,
        phase: u8,
    }

    struct PhaseStarted has copy, drop {
        timestamp: u64,
    }

    struct PhaseEnded has copy, drop {
        timestamp: u64,
    }

    struct WhitelistAdded has copy, drop {
        phase: u8,
        address: address,
        mint_limit: u64,
    }

    struct PriceUpdated has copy, drop {
        phase: u8,
        new_price: u64,
    }

    struct AdminUpdated has copy, drop {
        new_admin: address,
    }

    struct PAWTATO has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NewAdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct NFTCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        phase1_minted: u64,
        phase2_minted: u64,
        public_minted: u64,
        available_ids: vector<u64>,
        phase1_whitelist: 0x2::table::Table<address, u64>,
        phase2_whitelist: 0x2::table::Table<address, u64>,
        preset_attributes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        preset_urls: 0x2::table::Table<u64, 0x2::url::Url>,
        mint_start: u64,
        phase_end: u64,
        admin_address: address,
        treasury_address: address,
        phase1_price: u64,
        phase2_price: u64,
        public_price: u64,
    }

    struct LAND has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u64,
    }

    public fun add_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &AdminCap, arg1: &mut LAND, arg2: T0, arg3: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg1.id, arg2, arg3);
    }

    public fun add_dynamic_object_field<T0: copy + drop + store, T1: store + key>(arg0: &AdminCap, arg1: &mut LAND, arg2: T0, arg3: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg1.id, arg2, arg3);
    }

    public entry fun add_to_phase1(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun add_to_phase2(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun are_phases_active(arg0: &NFTCollection, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.mint_start && v0 <= arg0.phase_end
    }

    public fun borrow_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &LAND, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_dynamic_object_field<T0: copy + drop + store, T1: store + key>(arg0: &LAND, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_mut_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &AdminCap, arg1: &mut LAND, arg2: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg1.id, arg2)
    }

    public fun borrow_mut_dynamic_object_field<T0: copy + drop + store, T1: store + key>(arg0: &AdminCap, arg1: &mut LAND, arg2: T0) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg1.id, arg2)
    }

    public entry fun burn_nft(arg0: LAND, arg1: &mut NFTCollection) {
        let LAND {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
            token_id    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun burn_old_admin_cap(arg0: AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create_new_admin_cap(arg0: &0x2::package::UpgradeCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NewAdminCap{
            id      : 0x2::object::new(arg2),
            version : 1,
        };
        0x2::transfer::transfer<NewAdminCap>(v0, arg1);
    }

    fun create_nft(arg0: &NFTCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : LAND {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun end_phases(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase_end = 0x2::clock::timestamp_ms(arg2);
        let v0 = PhaseEnded{timestamp: arg1.phase_end};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public fun get_admin_address(arg0: &NFTCollection) : address {
        arg0.admin_address
    }

    public fun get_attributes(arg0: &LAND) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_collection_stats(arg0: &NFTCollection) : (u64, u64, u64, u64, u64) {
        (arg0.minted, arg0.phase1_minted, arg0.phase2_minted, arg0.public_minted, 0x1::vector::length<u64>(&arg0.available_ids))
    }

    public fun get_minted(arg0: &NFTCollection) : u64 {
        arg0.minted
    }

    public(friend) fun get_next_token_id_incr(arg0: &mut NFTCollection) : u64 {
        arg0.minted = arg0.minted + 1;
        arg0.minted
    }

    public fun get_phase1_minted(arg0: &NFTCollection) : u64 {
        arg0.phase1_minted
    }

    public fun get_phase2_minted(arg0: &NFTCollection) : u64 {
        arg0.phase2_minted
    }

    public fun get_public_minted(arg0: &NFTCollection) : u64 {
        arg0.public_minted
    }

    public fun get_remaining_mints(arg0: &NFTCollection, arg1: address, arg2: u8) : u64 {
        if (arg2 == 1 && 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.phase1_whitelist, arg1)
        } else if (arg2 == 2 && 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.phase2_whitelist, arg1)
        } else {
            0
        }
    }

    public fun get_remaining_nfts(arg0: &NFTCollection) : u64 {
        0x1::vector::length<u64>(&arg0.available_ids)
    }

    public fun get_token_id(arg0: &LAND) : u64 {
        arg0.token_id
    }

    public fun get_total_available_mints(arg0: &NFTCollection, arg1: address) : u64 {
        let (_, v1, _, v3) = get_wallet_allocations(arg0, arg1);
        v1 + v3
    }

    public fun get_total_mint_price(arg0: &NFTCollection, arg1: address) : u64 {
        let (_, v1, _, v3) = get_wallet_allocations(arg0, arg1);
        v1 * arg0.phase1_price + v3 * arg0.phase2_price
    }

    public fun get_total_supply() : u64 {
        15000
    }

    public fun get_wallet_allocations(arg0: &NFTCollection, arg1: address) : (bool, u64, bool, u64) {
        let v0 = 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1);
        let v1 = if (v0) {
            *0x2::table::borrow<address, u64>(&arg0.phase1_whitelist, arg1)
        } else {
            0
        };
        let v2 = 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1);
        let v3 = if (v2) {
            *0x2::table::borrow<address, u64>(&arg0.phase2_whitelist, arg1)
        } else {
            0
        };
        (v0, v1, v2, v3)
    }

    public fun has_dynamic_field<T0: copy + drop + store>(arg0: &LAND, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun has_dynamic_object_field<T0: copy + drop + store>(arg0: &LAND, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_<T0>(&arg0.id, arg1)
    }

    fun init(arg0: PAWTATO, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_public_mint_active(arg0: &NFTCollection, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.phase_end
    }

    public fun is_token_minted(arg0: &NFTCollection, arg1: u64) : bool {
        !0x1::vector::contains<u64>(&arg0.available_ids, &arg1)
    }

    public fun is_whitelisted_for_phase(arg0: &NFTCollection, arg1: address, arg2: u8) : bool {
        arg2 == 1 && 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1) || arg2 == 2 && 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1)
    }

    public entry fun mint_all(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<LAND>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun mint_phase1(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<LAND>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun mint_phase2(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<LAND>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun mint_public(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<LAND>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public(friend) fun mint_with_cap_and_attributes(arg0: &mut NFTCollection, arg1: u64, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : LAND {
        let v0 = 0x1::string::utf8(b"Pawtato Land #");
        0x1::string::append(&mut v0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1));
        let v1 = 0x1::string::utf8(b"https://img.pawtato.app/land/");
        0x1::string::append(&mut v1, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1));
        0x1::string::append(&mut v1, 0x1::string::utf8(b".png"));
        LAND{
            id          : 0x2::object::new(arg4),
            name        : v0,
            description : arg2,
            image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v1)),
            attributes  : arg3,
            token_id    : arg1,
        }
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = 18446744073709551615;
    }

    public fun remove_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &AdminCap, arg1: &mut LAND, arg2: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(&mut arg1.id, arg2)
    }

    public fun remove_dynamic_object_field<T0: copy + drop + store, T1: store + key>(arg0: &AdminCap, arg1: &mut LAND, arg2: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg1.id, arg2)
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = arg2;
    }

    public entry fun set_bulk_nft_attributes(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun set_bulk_nft_attributes_v2(arg0: &NewAdminCap, arg1: &mut NFTCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun set_bulk_nft_urls(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public(friend) fun set_influence(arg0: &mut LAND, arg1: u64) {
        let v0 = 0x1::string::utf8(b"Influence");
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_upgrade_prerequisite_not_met());
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1);
    }

    public entry fun set_nft_attributes(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun set_nft_attributes_v2(arg0: &NewAdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun set_nft_url(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun set_phase_end(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase_end = arg2;
        let v0 = PhaseEnded{timestamp: arg2};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public entry fun start_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = arg2;
        arg1.phase_end = arg2 + 3600000;
        let v0 = PhaseStarted{timestamp: arg2};
        0x2::event::emit<PhaseStarted>(v0);
    }

    public entry fun team_mint(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::transfer_policy::TransferPolicy<LAND>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun team_mint_batch(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::transfer_policy::TransferPolicy<LAND>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun team_mint_batch_v2(arg0: &NewAdminCap, arg1: &mut NFTCollection, arg2: &0x2::transfer_policy::TransferPolicy<LAND>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun update_admin_address(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    public entry fun update_phase1_price(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase1_price = arg2;
        let v0 = PriceUpdated{
            phase     : 1,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun update_phase2_price(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase2_price = arg2;
        let v0 = PriceUpdated{
            phase     : 2,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun update_public_price(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.public_price = arg2;
        let v0 = PriceUpdated{
            phase     : 100,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

