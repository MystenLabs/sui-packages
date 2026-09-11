module 0xc813dd750cff7592251334cd65e5d34a368cd6fbe3207103978415fbff877057::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ItemData has store {
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        size: u64,
        minted: u64,
        drawn: u64,
        seeded: u64,
        onchain_registry: bool,
        reveal_open: bool,
        registry: 0x2::table::Table<u64, ItemData>,
        seeded_flags: 0x2::table::Table<u64, bool>,
        shuffle: 0x2::table::Table<u64, u64>,
    }

    struct Phase has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        gated: bool,
        max_per_wallet: u64,
        is_open: bool,
    }

    struct SplitShare has copy, drop, store {
        recipient: address,
        bps: u64,
    }

    struct MintKey has copy, drop, store {
        phase: u64,
        who: address,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        platform_fee_bps: u64,
        platform_treasury: address,
        is_open: bool,
        splits: vector<SplitShare>,
        fixed_fee: u64,
        fixed_fee_recipient: address,
        phases: vector<Phase>,
        allowlist: 0x2::table::Table<address, bool>,
        minted_per_wallet: 0x2::table::Table<MintKey, u64>,
    }

    struct Pumplienz has store, key {
        id: 0x2::object::UID,
        number: u64,
        index: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        metadata_version: u64,
    }

    struct ItemMinted has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        recipient: address,
    }

    struct MintConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        treasury: address,
    }

    struct RevenueSplitSet has copy, drop {
        config_id: 0x2::object::ID,
        recipients: vector<address>,
        bps: vector<u64>,
        fixed_fee: u64,
        fixed_fee_recipient: address,
    }

    struct ItemRevealed has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        owner: address,
    }

    struct RevealGateSet has copy, drop {
        collection_id: 0x2::object::ID,
        open: bool,
    }

    struct ProvenanceSet has copy, drop {
        provenance: 0x2::object::ID,
        hash: vector<u8>,
    }

    struct ItemMetadataFixed has copy, drop {
        object_id: 0x2::object::ID,
        index: u64,
        owner: address,
        metadata_version: u64,
    }

    struct CorrectionsSealed has copy, drop {
        corrections_id: 0x2::object::ID,
    }

    struct RoyaltySplitter has key {
        id: 0x2::object::UID,
        cap: 0x2::transfer_policy::TransferPolicyCap<Pumplienz>,
        shares: vector<SplitShare>,
    }

    struct RoyaltyDistributed has copy, drop {
        splitter_id: 0x2::object::ID,
        total: u64,
        recipients: vector<address>,
    }

    struct ClaimGate has key {
        id: 0x2::object::UID,
        gate_type: 0x1::type_name::TypeName,
        cap: u64,
        used: u64,
        price: u64,
        treasury: address,
        is_open: bool,
        redeemed: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct ClaimGateCreated has copy, drop {
        gate_id: 0x2::object::ID,
        gate_type: 0x1::type_name::TypeName,
        cap: u64,
        price: u64,
    }

    struct Claimed has copy, drop {
        gate_id: 0x2::object::ID,
        token_id: 0x2::object::ID,
        who: address,
        used: u64,
    }

    struct Pinned has drop, store {
        recipient: address,
        price: u64,
        expires_at: u64,
        manual: bool,
    }

    struct ReservationBook has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        is_open: bool,
        pinned: 0x2::table::Table<u64, Pinned>,
        pinned_total: u64,
        moved: 0x2::table::Table<u64, u64>,
        manual_draws: u64,
    }

    struct ReservationBookCreated has copy, drop {
        book_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
    }

    struct PiecePinned has copy, drop {
        book_id: 0x2::object::ID,
        index: u64,
        recipient: address,
        price: u64,
        expires_at: u64,
        random: bool,
    }

    struct PieceUnpinned has copy, drop {
        book_id: 0x2::object::ID,
        index: u64,
    }

    struct PinnedMinted has copy, drop {
        book_id: 0x2::object::ID,
        index: u64,
        object_id: 0x2::object::ID,
        recipient: address,
        price: u64,
    }

    struct Provenance has key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        scheme: 0x1::string::String,
    }

    struct Corrections has key {
        id: 0x2::object::UID,
        fixes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        sealed: bool,
    }

    public fun add_to_allowlist(arg0: &AdminCap, arg1: &mut MintConfig, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.allowlist, v1)) {
                0x2::table::add<address, bool>(&mut arg1.allowlist, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    entry fun admin_mint(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: address, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert_mint_ready(arg1);
        assert_supply(arg1, arg2);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = &mut v0;
        draw_and_mint(arg1, arg2, arg3, v1, arg5);
    }

    entry fun admin_mint_many_recipients(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<address>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert_mint_ready(arg1);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 4);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 10, 6);
        assert!(arg1.minted + arg2 * v0 <= arg1.size, 8);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = &mut v1;
            draw_and_mint(arg1, arg2, *0x1::vector::borrow<address>(&arg3, v2), v3, arg5);
            v2 = v2 + 1;
        };
    }

    public fun admin_mint_pinned(arg0: &AdminCap, arg1: &mut ReservationBook, arg2: &mut Collection, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_book(arg1, arg2);
        assert_mint_ready(arg2);
        assert!(0x2::table::contains<u64, Pinned>(&arg1.pinned, arg3), 32);
        let Pinned {
            recipient  : v0,
            price      : _,
            expires_at : _,
            manual     : _,
        } = 0x2::table::remove<u64, Pinned>(&mut arg1.pinned, arg3);
        assert!(arg2.minted + 1 <= arg2.size, 8);
        arg1.pinned_total = arg1.pinned_total - 1;
        let v4 = PinnedMinted{
            book_id   : 0x2::object::id<ReservationBook>(arg1),
            index     : arg3,
            object_id : mint_pinned_piece(arg2, arg3, v0, arg4),
            recipient : v0,
            price     : 0,
        };
        0x2::event::emit<PinnedMinted>(v4);
    }

    fun assert_book(arg0: &ReservationBook, arg1: &Collection) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 36);
    }

    fun assert_claim(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.is_open, 28);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.redeemed, arg2), 26);
        assert!(arg0.used < arg0.cap, 27);
        assert_mint_ready(arg1);
        assert_supply(arg1, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        if (arg0.price > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.price, 3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.price, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.redeemed, arg2, true);
        arg0.used = arg0.used + 1;
        v0
    }

    fun assert_mint_ready(arg0: &Collection) {
        if (arg0.onchain_registry) {
            assert!(arg0.seeded == arg0.size, 11);
        };
    }

    fun assert_supply(arg0: &Collection, arg1: u64) {
        assert!(arg1 > 0, 4);
        assert!(arg1 <= 10, 6);
        assert!(arg0.minted + arg1 <= arg0.size, 8);
    }

    public fun attributes(arg0: &Pumplienz) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun available(arg0: &Collection) : u64 {
        arg0.size - arg0.minted
    }

    fun build_attributes(arg0: &vector<vector<u8>>, arg1: &vector<vector<u8>>, arg2: u64, arg3: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < arg3) {
            let v2 = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(arg0, arg2 + v1));
            assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &v2), 19);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, v2, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(arg1, arg2 + v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun build_shares(arg0: vector<address>, arg1: vector<u64>) : vector<SplitShare> {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 12);
        assert!(!0x1::vector::is_empty<address>(&arg0), 24);
        let v0 = 0x1::vector::empty<SplitShare>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0)) {
            let v3 = *0x1::vector::borrow<address>(&arg0, v2);
            assert!(v3 != @0x0, 24);
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1, v2);
            let v4 = SplitShare{
                recipient : v3,
                bps       : *0x1::vector::borrow<u64>(&arg1, v2),
            };
            0x1::vector::push_back<SplitShare>(&mut v0, v4);
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 24);
        v0
    }

    fun charge_and_check(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.is_open, 0);
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 10, 6);
        assert!(arg2 < 0x1::vector::length<Phase>(&arg0.phases), 5);
        let v0 = *0x1::vector::borrow<Phase>(&arg0.phases, arg2);
        assert!(v0.is_open, 16);
        assert!(v0.price <= arg4, 18);
        let v1 = 0x2::tx_context::sender(arg5);
        if (v0.gated) {
            assert!(0x2::table::contains<address, bool>(&arg0.allowlist, v1), 1);
        };
        let v2 = MintKey{
            phase : arg2,
            who   : v1,
        };
        let v3 = if (0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v2)) {
            *0x2::table::borrow<MintKey, u64>(&arg0.minted_per_wallet, v2)
        } else {
            0
        };
        if (v0.max_per_wallet > 0) {
            assert!(v3 + arg3 <= v0.max_per_wallet, 2);
        };
        let v4 = v0.price * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v4, 3);
        settle_payment(arg0, arg1, v4, arg3, v1, arg5);
        if (0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v2)) {
            *0x2::table::borrow_mut<MintKey, u64>(&mut arg0.minted_per_wallet, v2) = v3 + arg3;
        } else {
            0x2::table::add<MintKey, u64>(&mut arg0.minted_per_wallet, v2, v3 + arg3);
        };
        v1
    }

    public fun claim_cap(arg0: &ClaimGate) : u64 {
        arg0.cap
    }

    entry fun claim_mint<T0: key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        do_claim(arg0, arg1, 0x2::object::id<T0>(arg2), arg3, arg4, arg5);
    }

    entry fun claim_mint_from_kiosk<T0: store + key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        0x2::kiosk::borrow<T0>(arg2, arg3, arg4);
        do_claim(arg0, arg1, arg4, arg5, arg6, arg7);
    }

    entry fun claim_mint_from_kiosk_to_kiosk<T0: store + key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Pumplienz>, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        0x2::kiosk::borrow<T0>(arg2, arg3, arg5);
        do_claim_to_kiosk(arg0, arg1, arg5, arg6, arg2, arg3, arg4, arg7, arg8);
    }

    entry fun claim_mint_from_personal_kiosk<T0: store + key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        0x2::kiosk::borrow<T0>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg4);
        do_claim(arg0, arg1, arg4, arg5, arg6, arg7);
    }

    entry fun claim_mint_from_personal_kiosk_to_kiosk<T0: store + key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<Pumplienz>, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3);
        0x2::kiosk::borrow<T0>(arg2, v0, arg5);
        do_claim_to_kiosk(arg0, arg1, arg5, arg6, arg2, v0, arg4, arg7, arg8);
    }

    entry fun claim_mint_to_kiosk<T0: key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<Pumplienz>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        do_claim_to_kiosk(arg0, arg1, 0x2::object::id<T0>(arg2), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun claim_used(arg0: &ClaimGate) : u64 {
        arg0.used
    }

    public fun corrections_sealed(arg0: &Corrections) : bool {
        arg0.sealed
    }

    public fun create_claim_gate<T0: key>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg3 != @0x0, 7);
        let v0 = ClaimGate{
            id        : 0x2::object::new(arg4),
            gate_type : 0x1::type_name::with_defining_ids<T0>(),
            cap       : arg1,
            used      : 0,
            price     : arg2,
            treasury  : arg3,
            is_open   : false,
            redeemed  : 0x2::table::new<0x2::object::ID, bool>(arg4),
        };
        let v1 = ClaimGateCreated{
            gate_id   : 0x2::object::id<ClaimGate>(&v0),
            gate_type : v0.gate_type,
            cap       : arg1,
            price     : arg2,
        };
        0x2::event::emit<ClaimGateCreated>(v1);
        0x2::transfer::share_object<ClaimGate>(v0);
    }

    public fun create_corrections(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Corrections{
            id     : 0x2::object::new(arg1),
            fixes  : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            sealed : false,
        };
        0x2::transfer::share_object<Corrections>(v0);
    }

    public fun create_mint_config(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 7);
        assert!(0 <= 10000, 22);
        assert!(0 == 0 || @0x0 != @0x0, 22);
        let v0 = MintConfig{
            id                  : 0x2::object::new(arg2),
            treasury            : arg1,
            platform_fee_bps    : 0,
            platform_treasury   : @0x0,
            is_open             : false,
            splits              : 0x1::vector::empty<SplitShare>(),
            fixed_fee           : 0,
            fixed_fee_recipient : @0x0,
            phases              : 0x1::vector::empty<Phase>(),
            allowlist           : 0x2::table::new<address, bool>(arg2),
            minted_per_wallet   : 0x2::table::new<MintKey, u64>(arg2),
        };
        let v1 = MintConfigCreated{
            config_id : 0x2::object::id<MintConfig>(&v0),
            treasury  : arg1,
        };
        0x2::event::emit<MintConfigCreated>(v1);
        0x2::transfer::share_object<MintConfig>(v0);
    }

    public fun create_provenance(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Provenance{
            id     : 0x2::object::new(arg3),
            hash   : arg1,
            scheme : 0x1::string::utf8(arg2),
        };
        let v1 = ProvenanceSet{
            provenance : 0x2::object::id<Provenance>(&v0),
            hash       : v0.hash,
        };
        0x2::event::emit<ProvenanceSet>(v1);
        0x2::transfer::share_object<Provenance>(v0);
    }

    public fun create_reservation_book(arg0: &AdminCap, arg1: &Collection, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReservationBook{
            id            : 0x2::object::new(arg2),
            collection_id : 0x2::object::id<Collection>(arg1),
            is_open       : false,
            pinned        : 0x2::table::new<u64, Pinned>(arg2),
            pinned_total  : 0,
            moved         : 0x2::table::new<u64, u64>(arg2),
            manual_draws  : 0,
        };
        let v1 = ReservationBookCreated{
            book_id       : 0x2::object::id<ReservationBook>(&v0),
            collection_id : v0.collection_id,
        };
        0x2::event::emit<ReservationBookCreated>(v1);
        0x2::transfer::share_object<ReservationBook>(v0);
    }

    public fun create_royalty_splitter(arg0: &AdminCap, arg1: 0x2::transfer_policy::TransferPolicyCap<Pumplienz>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltySplitter{
            id     : 0x2::object::new(arg4),
            cap    : arg1,
            shares : build_shares(arg2, arg3),
        };
        0x2::transfer::share_object<RoyaltySplitter>(v0);
    }

    public fun distribute(arg0: &mut RoyaltySplitter, arg1: &mut 0x2::transfer_policy::TransferPolicy<Pumplienz>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<Pumplienz>(arg1, &arg0.cap, 0x1::option::none<u64>(), arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 > 0, 29);
        let v2 = 0x1::vector::length<SplitShare>(&arg0.shares);
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0;
        while (v4 < v2) {
            let v6 = *0x1::vector::borrow<SplitShare>(&arg0.shares, v4);
            let v7 = if (v4 + 1 == v2) {
                v1 - v5
            } else {
                v1 * v6.bps / 10000
            };
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v7, arg2), v6.recipient);
            };
            0x1::vector::push_back<address>(&mut v3, v6.recipient);
            v5 = v5 + v7;
            v4 = v4 + 1;
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        let v8 = RoyaltyDistributed{
            splitter_id : 0x2::object::id<RoyaltySplitter>(arg0),
            total       : v1,
            recipients  : v3,
        };
        0x2::event::emit<RoyaltyDistributed>(v8);
    }

    fun do_claim(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = assert_claim(arg0, arg1, arg2, arg3, arg5);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = &mut v1;
        draw_and_mint(arg1, 1, v0, v2, arg5);
        let v3 = Claimed{
            gate_id  : 0x2::object::id<ClaimGate>(arg0),
            token_id : arg2,
            who      : v0,
            used     : arg0.used,
        };
        0x2::event::emit<Claimed>(v3);
    }

    fun do_claim_to_kiosk(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<Pumplienz>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = assert_claim(arg0, arg1, arg2, arg3, arg8);
        let v1 = 0x2::random::new_generator(arg7, arg8);
        let v2 = &mut v1;
        let v3 = Claimed{
            gate_id  : 0x2::object::id<ClaimGate>(arg0),
            token_id : arg2,
            who      : v0,
            used     : arg0.used,
        };
        0x2::event::emit<Claimed>(v3);
        draw_and_lock(arg1, 1, arg4, arg5, arg6, v0, v2, arg8)
    }

    fun draw_and_lock(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Pumplienz>, arg5: address, arg6: &mut 0x2::random::RandomGenerator, arg7: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(arg0.reveal_open, 38);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = draw_index(arg0, arg6);
            let v3 = forge_one(arg0, v2, arg5, arg7);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Pumplienz>(&v3));
            0x2::kiosk::lock<Pumplienz>(arg2, arg3, arg4, v3);
            v1 = v1 + 1;
        };
        v0
    }

    fun draw_and_mint(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::random::RandomGenerator, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.reveal_open, 38);
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = draw_index(arg0, arg3);
            mint_one(arg0, v1, arg2, arg4);
            v0 = v0 + 1;
        };
    }

    fun draw_index(arg0: &mut Collection, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = arg0.size - arg0.drawn;
        let v1 = 0x2::random::generate_u64_in_range(arg1, 0, v0 - 1);
        let v2 = if (0x2::table::contains<u64, u64>(&arg0.shuffle, v1)) {
            *0x2::table::borrow<u64, u64>(&arg0.shuffle, v1)
        } else {
            v1
        };
        let v3 = v0 - 1;
        let v4 = if (0x2::table::contains<u64, u64>(&arg0.shuffle, v3)) {
            *0x2::table::borrow<u64, u64>(&arg0.shuffle, v3)
        } else {
            v3
        };
        if (v1 != v3) {
            if (0x2::table::contains<u64, u64>(&arg0.shuffle, v1)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg0.shuffle, v1) = v4;
            } else {
                0x2::table::add<u64, u64>(&mut arg0.shuffle, v1, v4);
            };
        };
        if (0x2::table::contains<u64, u64>(&arg0.shuffle, v3)) {
            0x2::table::remove<u64, u64>(&mut arg0.shuffle, v3);
        };
        arg0.drawn = arg0.drawn + 1;
        v2
    }

    public fun drawn(arg0: &Collection) : u64 {
        arg0.drawn
    }

    public fun fix_metadata(arg0: &Corrections, arg1: &mut Pumplienz, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.index != 0, 23);
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1.index), 17);
        arg1.attributes = *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1.index);
        arg1.metadata_version = arg1.metadata_version + 1;
        let v0 = ItemMetadataFixed{
            object_id        : 0x2::object::id<Pumplienz>(arg1),
            index            : arg1.index,
            owner            : 0x2::tx_context::sender(arg2),
            metadata_version : arg1.metadata_version,
        };
        0x2::event::emit<ItemMetadataFixed>(v0);
    }

    public fun fixed_fee(arg0: &MintConfig) : u64 {
        arg0.fixed_fee
    }

    fun forge_one(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Pumplienz {
        let v0 = if (arg0.onchain_registry) {
            assert!(0x2::table::contains<u64, ItemData>(&arg0.registry, arg1), 13);
            let ItemData { attributes: v0 } = 0x2::table::remove<u64, ItemData>(&mut arg0.registry, arg1);
            v0
        } else {
            0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()
        };
        arg0.minted = arg0.minted + 1;
        let v1 = arg0.minted;
        let v2 = arg1 + 1;
        let v3 = Pumplienz{
            id               : 0x2::object::new(arg3),
            number           : v1,
            index            : v2,
            attributes       : v0,
            metadata_version : 1,
        };
        let v4 = ItemMinted{
            object_id : 0x2::object::id<Pumplienz>(&v3),
            number    : v1,
            index     : v2,
            recipient : arg2,
        };
        0x2::event::emit<ItemMinted>(v4);
        v3
    }

    public fun has_correction(arg0: &Corrections, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1)
    }

    public fun index(arg0: &Pumplienz) : u64 {
        arg0.index
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = 0x2::display::new<Pumplienz>(&v1, arg1);
        0x2::display::add<Pumplienz>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Pumplienz #{index}"));
        0x2::display::add<Pumplienz>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A crew of hand drawn rebellious alien misfits built layer by layer in the Alienz Hive."));
        let v3 = 0x1::string::utf8(b"https://assets.alienz.tech/collections/6a144715bb27a402f898fca7618f8b47918ce311a0fad3ed638cb040725ed0f6/tokens/");
        0x1::string::append(&mut v3, 0x1::string::utf8(b"{index}."));
        0x1::string::append(&mut v3, 0x1::string::utf8(b"webp"));
        0x2::display::add<Pumplienz>(&mut v2, 0x1::string::utf8(b"image_url"), v3);
        if (false) {
            let v4 = 0x1::string::utf8(b"https://assets.alienz.tech/collections/6a144715bb27a402f898fca7618f8b47918ce311a0fad3ed638cb040725ed0f6/tokens/");
            0x1::string::append(&mut v4, 0x1::string::utf8(b"{index}."));
            0x1::string::append(&mut v4, 0x1::string::utf8(b"mp4"));
            0x2::display::add<Pumplienz>(&mut v2, 0x1::string::utf8(b"animation_url"), v4);
        };
        0x2::display::add<Pumplienz>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://pumplienz.suipump.org/"));
        0x2::display::add<Pumplienz>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Alienztech"));
        0x2::display::update_version<Pumplienz>(&mut v2);
        let (v5, v6) = 0x2::transfer_policy::new<Pumplienz>(&v1, arg1);
        let v7 = v6;
        let v8 = v5;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Pumplienz>(&mut v8, &v7, 500, 125000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Pumplienz>(&mut v8, &v7);
        let v9 = Collection{
            id               : 0x2::object::new(arg1),
            name             : 0x1::string::utf8(b"Pumplienz"),
            size             : 2555,
            minted           : 0,
            drawn            : 0,
            seeded           : 0,
            onchain_registry : true,
            reveal_open      : false,
            registry         : 0x2::table::new<u64, ItemData>(arg1),
            seeded_flags     : 0x2::table::new<u64, bool>(arg1),
            shuffle          : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Pumplienz>>(v8);
        0x2::transfer::share_object<Collection>(v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Pumplienz>>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Pumplienz>>(v2, v0);
        let v10 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v10, v0);
    }

    public fun is_allowlisted(arg0: &MintConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.allowlist, arg1)
    }

    public fun is_fully_seeded(arg0: &Collection) : bool {
        arg0.seeded == arg0.size
    }

    public fun is_index_seeded(arg0: &Collection, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.seeded_flags, arg1)
    }

    public fun is_onchain_registry(arg0: &Collection) : bool {
        arg0.onchain_registry
    }

    public fun is_open(arg0: &MintConfig) : bool {
        arg0.is_open
    }

    public fun is_pinned(arg0: &ReservationBook, arg1: u64) : bool {
        0x2::table::contains<u64, Pinned>(&arg0.pinned, arg1)
    }

    public fun is_redeemed(arg0: &ClaimGate, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.redeemed, arg1)
    }

    public fun is_revealed(arg0: &Pumplienz) : bool {
        arg0.index != 0
    }

    public fun metadata_version(arg0: &Pumplienz) : u64 {
        arg0.metadata_version
    }

    fun mint_boxes_internal(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            arg0.minted = arg0.minted + 1;
            let v1 = arg0.minted;
            let v2 = Pumplienz{
                id               : 0x2::object::new(arg3),
                number           : v1,
                index            : 0,
                attributes       : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                metadata_version : 0,
            };
            let v3 = ItemMinted{
                object_id : 0x2::object::id<Pumplienz>(&v2),
                number    : v1,
                index     : 0,
                recipient : arg2,
            };
            0x2::event::emit<ItemMinted>(v3);
            0x2::transfer::public_transfer<Pumplienz>(v2, arg2);
            v0 = v0 + 1;
        };
    }

    fun mint_boxes_into_kiosk(arg0: &mut MintConfig, arg1: &mut Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Pumplienz>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(arg1.onchain_registry, 20);
        assert_mint_ready(arg1);
        assert_supply(arg1, arg7);
        let v0 = charge_and_check(arg0, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < arg7) {
            arg1.minted = arg1.minted + 1;
            let v3 = arg1.minted;
            let v4 = Pumplienz{
                id               : 0x2::object::new(arg9),
                number           : v3,
                index            : 0,
                attributes       : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                metadata_version : 0,
            };
            let v5 = 0x2::object::id<Pumplienz>(&v4);
            let v6 = ItemMinted{
                object_id : v5,
                number    : v3,
                index     : 0,
                recipient : v0,
            };
            0x2::event::emit<ItemMinted>(v6);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v5);
            0x2::kiosk::lock<Pumplienz>(arg2, arg3, arg4, v4);
            v2 = v2 + 1;
        };
        v1
    }

    fun mint_one(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = forge_one(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<Pumplienz>(v0, arg2);
        0x2::object::id<Pumplienz>(&v0)
    }

    entry fun mint_pinned(arg0: &mut ReservationBook, arg1: &mut Collection, arg2: &MintConfig, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_book(arg0, arg1);
        assert!(arg0.is_open, 35);
        assert_mint_ready(arg1);
        assert!(0x2::table::contains<u64, Pinned>(&arg0.pinned, arg3), 32);
        let v0 = 0x2::tx_context::sender(arg6);
        let Pinned {
            recipient  : v1,
            price      : v2,
            expires_at : v3,
            manual     : _,
        } = 0x2::table::remove<u64, Pinned>(&mut arg0.pinned, arg3);
        assert!(v1 == v0, 33);
        assert!(v3 == 0 || 0x2::clock::timestamp_ms(arg5) <= v3, 34);
        assert!(arg1.minted + 1 <= arg1.size, 8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2, 3);
        arg0.pinned_total = arg0.pinned_total - 1;
        settle_payment(arg2, arg4, v2, 1, v0, arg6);
        let v5 = PinnedMinted{
            book_id   : 0x2::object::id<ReservationBook>(arg0),
            index     : arg3,
            object_id : mint_pinned_piece(arg1, arg3, v0, arg6),
            recipient : v0,
            price     : v2,
        };
        0x2::event::emit<PinnedMinted>(v5);
    }

    fun mint_pinned_piece(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        mint_one(arg0, arg1, arg2, arg3)
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun minted_by_in_phase(arg0: &MintConfig, arg1: u64, arg2: address) : u64 {
        let v0 = MintKey{
            phase : arg1,
            who   : arg2,
        };
        if (0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v0)) {
            *0x2::table::borrow<MintKey, u64>(&arg0.minted_per_wallet, v0)
        } else {
            0
        }
    }

    public fun number(arg0: &Pumplienz) : u64 {
        arg0.number
    }

    public fun phase_at(arg0: &MintConfig, arg1: u64) : (0x1::string::String, u64, bool, u64, bool) {
        let v0 = 0x1::vector::borrow<Phase>(&arg0.phases, arg1);
        (v0.name, v0.price, v0.gated, v0.max_per_wallet, v0.is_open)
    }

    public fun phase_count(arg0: &MintConfig) : u64 {
        0x1::vector::length<Phase>(&arg0.phases)
    }

    public fun phase_is_open(arg0: &MintConfig, arg1: u64) : bool {
        assert!(arg1 < 0x1::vector::length<Phase>(&arg0.phases), 5);
        0x1::vector::borrow<Phase>(&arg0.phases, arg1).is_open
    }

    public fun pin(arg0: &AdminCap, arg1: &mut ReservationBook, arg2: &mut Collection, arg3: u64, arg4: address, arg5: u64, arg6: u64) {
        assert_book(arg1, arg2);
        assert!(arg2.drawn == arg1.manual_draws, 30);
        assert!(arg3 < arg2.size, 37);
        assert!(!0x2::table::contains<u64, Pinned>(&arg1.pinned, arg3), 31);
        assert!(arg4 != @0x0, 7);
        let v0 = arg2.size - arg2.drawn;
        let v1 = if (0x2::table::contains<u64, u64>(&arg1.moved, arg3)) {
            *0x2::table::borrow<u64, u64>(&arg1.moved, arg3)
        } else {
            arg3
        };
        assert!(v1 < v0, 37);
        assert!(value_at(arg2, v1) == arg3, 37);
        let v2 = v0 - 1;
        let v3 = value_at(arg2, v2);
        if (v1 != v2) {
            if (0x2::table::contains<u64, u64>(&arg2.shuffle, v1)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg2.shuffle, v1) = v3;
            } else {
                0x2::table::add<u64, u64>(&mut arg2.shuffle, v1, v3);
            };
            set_moved(arg1, v3, v1);
        };
        if (0x2::table::contains<u64, u64>(&arg2.shuffle, v2)) {
            0x2::table::remove<u64, u64>(&mut arg2.shuffle, v2);
        };
        if (0x2::table::contains<u64, u64>(&arg1.moved, arg3)) {
            0x2::table::remove<u64, u64>(&mut arg1.moved, arg3);
        };
        arg2.drawn = arg2.drawn + 1;
        arg1.manual_draws = arg1.manual_draws + 1;
        let v4 = Pinned{
            recipient  : arg4,
            price      : arg5,
            expires_at : arg6,
            manual     : true,
        };
        0x2::table::add<u64, Pinned>(&mut arg1.pinned, arg3, v4);
        arg1.pinned_total = arg1.pinned_total + 1;
        let v5 = PiecePinned{
            book_id    : 0x2::object::id<ReservationBook>(arg1),
            index      : arg3,
            recipient  : arg4,
            price      : arg5,
            expires_at : arg6,
            random     : false,
        };
        0x2::event::emit<PiecePinned>(v5);
    }

    public fun pinned_reservation(arg0: &ReservationBook, arg1: u64) : (address, u64, u64, bool) {
        assert!(0x2::table::contains<u64, Pinned>(&arg0.pinned, arg1), 32);
        let v0 = 0x2::table::borrow<u64, Pinned>(&arg0.pinned, arg1);
        (v0.recipient, v0.price, v0.expires_at, v0.manual)
    }

    public fun pinned_total(arg0: &ReservationBook) : u64 {
        arg0.pinned_total
    }

    public fun platform_fee_bps(arg0: &MintConfig) : u64 {
        arg0.platform_fee_bps
    }

    public fun platform_treasury(arg0: &MintConfig) : address {
        arg0.platform_treasury
    }

    public fun provenance_hash(arg0: &Provenance) : vector<u8> {
        arg0.hash
    }

    public fun provenance_scheme(arg0: &Provenance) : 0x1::string::String {
        arg0.scheme
    }

    entry fun public_mint_box_many(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.onchain_registry, 20);
        assert_mint_ready(arg1);
        assert_supply(arg1, arg4);
        let v0 = charge_and_check(arg0, arg2, arg3, arg4, arg5, arg6);
        mint_boxes_internal(arg1, arg4, v0, arg6);
    }

    entry fun public_mint_box_many_to_kiosk(arg0: &mut MintConfig, arg1: &mut Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Pumplienz>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        mint_boxes_into_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun public_mint_many(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert_mint_ready(arg1);
        assert_supply(arg1, arg4);
        let v0 = charge_and_check(arg0, arg2, arg3, arg4, arg5, arg7);
        let v1 = 0x2::random::new_generator(arg6, arg7);
        let v2 = &mut v1;
        draw_and_mint(arg1, arg4, v0, v2, arg7);
    }

    public fun push_phase(arg0: &AdminCap, arg1: &mut MintConfig, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u64) {
        let v0 = Phase{
            name           : 0x1::string::utf8(arg2),
            price          : arg3,
            gated          : arg4,
            max_per_wallet : arg5,
            is_open        : false,
        };
        0x1::vector::push_back<Phase>(&mut arg1.phases, v0);
    }

    public fun remaining(arg0: &Collection) : u64 {
        arg0.size - arg0.drawn
    }

    public fun remove_from_allowlist(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.allowlist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.allowlist, arg2);
        };
    }

    public fun reservation_book_open(arg0: &ReservationBook) : bool {
        arg0.is_open
    }

    public fun reservations_pinnable(arg0: &ReservationBook, arg1: &Collection) : bool {
        arg1.drawn == arg0.manual_draws
    }

    entry fun reserve_random_lot(arg0: &AdminCap, arg1: &mut ReservationBook, arg2: &mut Collection, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert_book(arg1, arg2);
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 10, 6);
        assert!(arg4 != @0x0, 7);
        assert!(arg2.drawn + arg3 <= arg2.size, 8);
        let v0 = 0x2::random::new_generator(arg7, arg8);
        let v1 = 0;
        while (v1 < arg3) {
            let v2 = &mut v0;
            let v3 = draw_index(arg2, v2);
            let v4 = Pinned{
                recipient  : arg4,
                price      : arg5,
                expires_at : arg6,
                manual     : false,
            };
            0x2::table::add<u64, Pinned>(&mut arg1.pinned, v3, v4);
            arg1.pinned_total = arg1.pinned_total + 1;
            let v5 = PiecePinned{
                book_id    : 0x2::object::id<ReservationBook>(arg1),
                index      : v3,
                recipient  : arg4,
                price      : arg5,
                expires_at : arg6,
                random     : true,
            };
            0x2::event::emit<PiecePinned>(v5);
            v1 = v1 + 1;
        };
    }

    entry fun reveal(arg0: &mut Collection, arg1: &mut Pumplienz, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = &mut v0;
        reveal_inner(arg0, arg1, v1, arg3);
    }

    entry fun reveal_in_kiosk(arg0: &mut Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = 0x2::kiosk::borrow_mut<Pumplienz>(arg1, arg2, arg3);
        let v2 = &mut v0;
        reveal_inner(arg0, v1, v2, arg5);
    }

    fun reveal_inner(arg0: &mut Collection, arg1: &mut Pumplienz, arg2: &mut 0x2::random::RandomGenerator, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.onchain_registry, 20);
        assert!(arg0.reveal_open, 38);
        assert!(arg1.index == 0, 14);
        assert!(arg0.drawn < arg0.size, 15);
        let v0 = draw_index(arg0, arg2);
        assert!(0x2::table::contains<u64, ItemData>(&arg0.registry, v0), 13);
        let ItemData { attributes: v1 } = 0x2::table::remove<u64, ItemData>(&mut arg0.registry, v0);
        arg1.index = v0 + 1;
        arg1.attributes = v1;
        arg1.metadata_version = 1;
        let v2 = ItemRevealed{
            object_id : 0x2::object::id<Pumplienz>(arg1),
            number    : arg1.number,
            index     : arg1.index,
            owner     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ItemRevealed>(v2);
    }

    entry fun reveal_many(arg0: &mut Collection, arg1: vector<Pumplienz>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Pumplienz>(&arg1);
        assert!(v0 > 0, 4);
        assert!(v0 <= 10, 6);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        while (!0x1::vector::is_empty<Pumplienz>(&arg1)) {
            let v2 = 0x1::vector::pop_back<Pumplienz>(&mut arg1);
            let v3 = &mut v2;
            let v4 = &mut v1;
            reveal_inner(arg0, v3, v4, arg3);
            0x2::transfer::public_transfer<Pumplienz>(v2, 0x2::tx_context::sender(arg3));
        };
        0x1::vector::destroy_empty<Pumplienz>(arg1);
    }

    public fun reveal_open(arg0: &Collection) : bool {
        arg0.reveal_open
    }

    public fun royalty_share_count(arg0: &RoyaltySplitter) : u64 {
        0x1::vector::length<SplitShare>(&arg0.shares)
    }

    public fun seal_corrections(arg0: &AdminCap, arg1: &mut Corrections) {
        arg1.sealed = true;
        let v0 = CorrectionsSealed{corrections_id: 0x2::object::id<Corrections>(arg1)};
        0x2::event::emit<CorrectionsSealed>(v0);
    }

    public fun seed_correction(arg0: &AdminCap, arg1: &mut Corrections, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) {
        assert!(!arg1.sealed, 21);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 12);
        if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.fixes, arg2)) {
            *0x2::table::borrow_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.fixes, arg2) = build_attributes(&arg3, &arg4, 0, 0x1::vector::length<vector<u8>>(&arg3));
        } else {
            0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.fixes, arg2, build_attributes(&arg3, &arg4, 0, 0x1::vector::length<vector<u8>>(&arg3)));
        };
    }

    public fun seed_item(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 12);
        seed_one(arg1, arg2, build_attributes(&arg3, &arg4, 0, 0x1::vector::length<vector<u8>>(&arg3)));
    }

    public fun seed_items_batch(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 12);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<vector<u8>>(&arg5), 12);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            seed_one(arg1, *0x1::vector::borrow<u64>(&arg2, v1), build_attributes(&arg4, &arg5, v2, v3));
            v2 = v2 + v3;
            v1 = v1 + 1;
        };
        assert!(v2 == 0x1::vector::length<vector<u8>>(&arg4), 12);
    }

    fun seed_one(arg0: &mut Collection, arg1: u64, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        assert!(arg0.onchain_registry, 20);
        assert!(arg1 < arg0.size, 9);
        assert!(!0x2::table::contains<u64, bool>(&arg0.seeded_flags, arg1), 10);
        0x2::table::add<u64, bool>(&mut arg0.seeded_flags, arg1, true);
        let v0 = ItemData{attributes: arg2};
        0x2::table::add<u64, ItemData>(&mut arg0.registry, arg1, v0);
        arg0.seeded = arg0.seeded + 1;
    }

    public fun seeded(arg0: &Collection) : u64 {
        arg0.seeded
    }

    public fun set_claim_gate(arg0: &AdminCap, arg1: &mut ClaimGate, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg2 <= arg1.cap, 24);
        assert!(arg2 >= arg1.used, 24);
        assert!(arg3 == 0 || arg1.treasury != @0x0, 7);
        arg1.cap = arg2;
        arg1.price = arg3;
        arg1.is_open = arg4;
    }

    fun set_moved(arg0: &mut ReservationBook, arg1: u64, arg2: u64) {
        if (0x2::table::contains<u64, u64>(&arg0.moved, arg1)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.moved, arg1) = arg2;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.moved, arg1, arg2);
        };
    }

    public fun set_open(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun set_phase_open(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: bool) {
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 5);
        0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2).is_open = arg3;
    }

    public fun set_phase_params(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: u64, arg4: bool, arg5: u64) {
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 5);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        v0.price = arg3;
        v0.gated = arg4;
        v0.max_per_wallet = arg5;
    }

    public fun set_reservation_book_open(arg0: &AdminCap, arg1: &mut ReservationBook, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun set_reveal_open(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        arg1.reveal_open = arg2;
        let v0 = RevealGateSet{
            collection_id : 0x2::object::id<Collection>(arg1),
            open          : arg2,
        };
        0x2::event::emit<RevealGateSet>(v0);
    }

    public fun set_revenue_split(arg0: &AdminCap, arg1: &mut MintConfig, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: address) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 12);
        let v0 = 0x1::vector::empty<SplitShare>();
        if (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0;
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg2)) {
                let v3 = *0x1::vector::borrow<address>(&arg2, v2);
                let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
                assert!(v3 != @0x0, 24);
                v1 = v1 + v4;
                let v5 = SplitShare{
                    recipient : v3,
                    bps       : v4,
                };
                0x1::vector::push_back<SplitShare>(&mut v0, v5);
                v2 = v2 + 1;
            };
            assert!(v1 == 10000, 24);
        };
        assert!(arg4 == 0 || arg5 != @0x0, 24);
        assert!(arg4 == 0 || !0x1::vector::is_empty<SplitShare>(&v0), 24);
        let v6 = 0;
        while (v6 < 0x1::vector::length<Phase>(&arg1.phases)) {
            let v7 = *0x1::vector::borrow<Phase>(&arg1.phases, v6);
            if (v7.price > 0) {
                assert!(arg4 <= v7.price, 24);
            };
            v6 = v6 + 1;
        };
        arg1.splits = v0;
        arg1.fixed_fee = arg4;
        arg1.fixed_fee_recipient = arg5;
        let v8 = RevenueSplitSet{
            config_id           : 0x2::object::id<MintConfig>(arg1),
            recipients          : arg2,
            bps                 : arg3,
            fixed_fee           : arg4,
            fixed_fee_recipient : arg5,
        };
        0x2::event::emit<RevenueSplitSet>(v8);
    }

    public fun set_royalty_split(arg0: &AdminCap, arg1: &mut RoyaltySplitter, arg2: vector<address>, arg3: vector<u64>) {
        arg1.shares = build_shares(arg2, arg3);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        assert!(arg2 != @0x0, 7);
        arg1.treasury = arg2;
    }

    fun settle_payment(arg0: &MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            let v0 = arg2 * arg0.platform_fee_bps / 10000;
            if (v0 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg5), arg0.platform_treasury);
            };
            let v1 = arg2 - v0;
            let v2 = v1;
            if (0x1::vector::is_empty<SplitShare>(&arg0.splits)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg5), arg0.treasury);
            } else {
                let v3 = arg0.fixed_fee * arg3;
                assert!(v3 <= v1, 24);
                if (v3 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg5), arg0.fixed_fee_recipient);
                    v2 = v1 - v3;
                };
                let v4 = 0x1::vector::length<SplitShare>(&arg0.splits);
                let v5 = 0;
                let v6 = 0;
                while (v5 < v4) {
                    let v7 = *0x1::vector::borrow<SplitShare>(&arg0.splits, v5);
                    let v8 = if (v5 + 1 == v4) {
                        v2 - v6
                    } else {
                        v2 * v7.bps / 10000
                    };
                    if (v8 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v8, arg5), v7.recipient);
                    };
                    v6 = v6 + v8;
                    v5 = v5 + 1;
                };
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg4);
    }

    public fun size(arg0: &Collection) : u64 {
        arg0.size
    }

    public fun split_count(arg0: &MintConfig) : u64 {
        0x1::vector::length<SplitShare>(&arg0.splits)
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury(arg0: &MintConfig) : address {
        arg0.treasury
    }

    public fun unpin(arg0: &AdminCap, arg1: &mut ReservationBook, arg2: &mut Collection, arg3: u64) {
        assert_book(arg1, arg2);
        assert!(0x2::table::contains<u64, Pinned>(&arg1.pinned, arg3), 32);
        let Pinned {
            recipient  : _,
            price      : _,
            expires_at : _,
            manual     : v3,
        } = 0x2::table::remove<u64, Pinned>(&mut arg1.pinned, arg3);
        arg1.pinned_total = arg1.pinned_total - 1;
        let v4 = arg2.size - arg2.drawn;
        if (v4 != arg3) {
            if (0x2::table::contains<u64, u64>(&arg2.shuffle, v4)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg2.shuffle, v4) = arg3;
            } else {
                0x2::table::add<u64, u64>(&mut arg2.shuffle, v4, arg3);
            };
            set_moved(arg1, arg3, v4);
        } else if (0x2::table::contains<u64, u64>(&arg2.shuffle, v4)) {
            0x2::table::remove<u64, u64>(&mut arg2.shuffle, v4);
        };
        arg2.drawn = arg2.drawn - 1;
        if (v3) {
            arg1.manual_draws = arg1.manual_draws - 1;
        };
        let v5 = PieceUnpinned{
            book_id : 0x2::object::id<ReservationBook>(arg1),
            index   : arg3,
        };
        0x2::event::emit<PieceUnpinned>(v5);
    }

    public fun unrevealed(arg0: &Collection) : u64 {
        arg0.minted - arg0.drawn
    }

    fun value_at(arg0: &Collection, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.shuffle, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.shuffle, arg1)
        } else {
            arg1
        }
    }

    // decompiled from Move bytecode v7
}

