module 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks {
    struct SPUNKS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PunkData has store {
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        size: u64,
        minted: u64,
        seeded: u64,
        registry: 0x2::table::Table<u64, PunkData>,
        remaining: u64,
        shuffle: 0x2::table::Table<u64, u64>,
    }

    struct Phase has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        gated: bool,
        max_per_wallet: u64,
    }

    struct MintKey has copy, drop, store {
        phase: u64,
        who: address,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        is_open: bool,
        active_phase: u64,
        phases: vector<Phase>,
        allowlist: 0x2::table::Table<address, bool>,
        minted_per_wallet: 0x2::table::Table<MintKey, u64>,
    }

    struct Punk has store, key {
        id: 0x2::object::UID,
        number: u64,
        index: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PunkMinted has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        recipient: address,
    }

    struct MintConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        treasury: address,
    }

    struct PunkRevealed has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        owner: address,
    }

    struct ProvenanceSet has copy, drop {
        provenance: 0x2::object::ID,
        hash: vector<u8>,
    }

    struct Provenance has key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        scheme: 0x1::string::String,
    }

    struct Corrections has key {
        id: 0x2::object::UID,
        fixes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
    }

    struct PunkMetadataFixed has copy, drop {
        object_id: 0x2::object::ID,
        index: u64,
        owner: address,
    }

    struct RerollPool has key {
        id: 0x2::object::UID,
        is_open: bool,
        price: u64,
        treasury: address,
        size: u64,
        seeded: u64,
        remaining: u64,
        registry: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        shuffle: 0x2::table::Table<u64, u64>,
        rerolled: 0x2::table::Table<u64, u64>,
    }

    struct PunkRerolled has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        pool_piece: u64,
        owner: address,
    }

    public fun active_phase(arg0: &MintConfig) : (0x1::string::String, u64, bool, u64) {
        phase_at(arg0, arg0.active_phase)
    }

    public fun active_phase_index(arg0: &MintConfig) : u64 {
        arg0.active_phase
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
        assert!(arg1.seeded == arg1.size, 11);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 20, 6);
        assert!(arg1.remaining >= arg2, 8);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = &mut v0;
        draw_and_mint(arg1, arg2, arg3, v1, arg5);
    }

    entry fun admin_mint_many_recipients(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<address>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seeded == arg1.size, 11);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 20, 6);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 4);
        assert!(arg1.remaining >= arg2 * v0, 8);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = &mut v1;
            draw_and_mint(arg1, arg2, *0x1::vector::borrow<address>(&arg3, v2), v3, arg5);
            v2 = v2 + 1;
        };
    }

    public fun attributes(arg0: &Punk) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    fun charge_and_check(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : address {
        let v0 = arg0.active_phase;
        charge_and_check_for_phase(arg0, arg1, v0, arg2, arg3)
    }

    fun charge_and_check_for_phase(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.is_open, 0);
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 20, 6);
        assert!(arg2 < 0x1::vector::length<Phase>(&arg0.phases), 5);
        assert!(phase_is_open(arg0, arg2), 16);
        let v0 = *0x1::vector::borrow<Phase>(&arg0.phases, arg2);
        let v1 = 0x2::tx_context::sender(arg4);
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
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        if (0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v2)) {
            *0x2::table::borrow_mut<MintKey, u64>(&mut arg0.minted_per_wallet, v2) = v3 + arg3;
        } else {
            0x2::table::add<MintKey, u64>(&mut arg0.minted_per_wallet, v2, v3 + arg3);
        };
        v1
    }

    public fun create_corrections(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Corrections{
            id    : 0x2::object::new(arg1),
            fixes : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
        };
        0x2::transfer::share_object<Corrections>(v0);
    }

    public fun create_mint_config(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 7);
        let v0 = MintConfig{
            id                : 0x2::object::new(arg2),
            treasury          : arg1,
            is_open           : false,
            active_phase      : 0,
            phases            : 0x1::vector::empty<Phase>(),
            allowlist         : 0x2::table::new<address, bool>(arg2),
            minted_per_wallet : 0x2::table::new<MintKey, u64>(arg2),
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

    public fun create_reroll_pool(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 7);
        let v0 = RerollPool{
            id        : 0x2::object::new(arg4),
            is_open   : false,
            price     : arg2,
            treasury  : arg3,
            size      : arg1,
            seeded    : 0,
            remaining : arg1,
            registry  : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg4),
            shuffle   : 0x2::table::new<u64, u64>(arg4),
            rerolled  : 0x2::table::new<u64, u64>(arg4),
        };
        0x2::transfer::share_object<RerollPool>(v0);
    }

    fun draw_and_mint(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::random::RandomGenerator, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = draw_index(arg0, arg3);
            mint_one(arg0, v1, arg2, arg4);
            v0 = v0 + 1;
        };
    }

    fun draw_index(arg0: &mut Collection, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = arg0.remaining;
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
        arg0.remaining = v0 - 1;
        v2
    }

    fun draw_pool(arg0: &mut RerollPool, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = arg0.remaining;
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
        arg0.remaining = v0 - 1;
        v2
    }

    public fun fix_metadata(arg0: &Corrections, arg1: &mut Punk, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1.index), 17);
        arg1.attributes = *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1.index);
        let v0 = PunkMetadataFixed{
            object_id : 0x2::object::id<Punk>(arg1),
            index     : arg1.index,
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PunkMetadataFixed>(v0);
    }

    public fun has_correction(arg0: &Corrections, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1)
    }

    public fun index(arg0: &Punk) : u64 {
        arg0.index
    }

    fun init(arg0: SPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SPUNKS>(arg0, arg1);
        let v2 = 0x2::display::new<Punk>(&v1, arg1);
        0x2::display::add<Punk>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sui Punk #{index}"));
        0x2::display::add<Punk>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A Sui Punk, randomly minted on-chain (blind mint + reveal). Website: https://spunks.alienz.tech/ Discord: https://discord.gg/TRWFztdHp"));
        let v3 = 0x1::string::utf8(b"https://spunks.alienz.tech/punks/");
        0x1::string::append(&mut v3, 0x1::string::utf8(b"{index}.webp"));
        0x2::display::add<Punk>(&mut v2, 0x1::string::utf8(b"image_url"), v3);
        0x2::display::add<Punk>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://spunks.alienz.tech/"));
        0x2::display::add<Punk>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Sui Punks"));
        0x2::display::update_version<Punk>(&mut v2);
        let (v4, v5) = 0x2::transfer_policy::new<Punk>(&v1, arg1);
        let v6 = v5;
        let v7 = v4;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Punk>(&mut v7, &v6, 500, 125000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Punk>(&mut v7, &v6);
        let v8 = Collection{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"Sui Punks"),
            size      : 480,
            minted    : 0,
            seeded    : 0,
            registry  : 0x2::table::new<u64, PunkData>(arg1),
            remaining : 480,
            shuffle   : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Punk>>(v7);
        0x2::transfer::share_object<Collection>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Punk>>(v6, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Punk>>(v2, v0);
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v9, v0);
    }

    public fun is_allowlisted(arg0: &MintConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.allowlist, arg1)
    }

    public fun is_fully_seeded(arg0: &Collection) : bool {
        arg0.seeded == arg0.size
    }

    public fun is_open(arg0: &MintConfig) : bool {
        arg0.is_open
    }

    public fun is_revealed(arg0: &Punk) : bool {
        arg0.index != 0
    }

    fun mint_one(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, PunkData>(&arg0.registry, arg1), 13);
        let PunkData { attributes: v0 } = 0x2::table::remove<u64, PunkData>(&mut arg0.registry, arg1);
        arg0.minted = arg0.minted + 1;
        let v1 = arg0.minted;
        let v2 = arg1 + 1;
        let v3 = Punk{
            id         : 0x2::object::new(arg3),
            number     : v1,
            index      : v2,
            attributes : v0,
        };
        let v4 = PunkMinted{
            object_id : 0x2::object::id<Punk>(&v3),
            number    : v1,
            index     : v2,
            recipient : arg2,
        };
        0x2::event::emit<PunkMinted>(v4);
        0x2::transfer::public_transfer<Punk>(v3, arg2);
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

    public fun number(arg0: &Punk) : u64 {
        arg0.number
    }

    public fun phase_at(arg0: &MintConfig, arg1: u64) : (0x1::string::String, u64, bool, u64) {
        let v0 = 0x1::vector::borrow<Phase>(&arg0.phases, arg1);
        (v0.name, v0.price, v0.gated, v0.max_per_wallet)
    }

    public fun phase_count(arg0: &MintConfig) : u64 {
        0x1::vector::length<Phase>(&arg0.phases)
    }

    public fun phase_is_open(arg0: &MintConfig, arg1: u64) : bool {
        assert!(arg1 < 0x1::vector::length<Phase>(&arg0.phases), 5);
        let v0 = phase_open_key(arg1);
        0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v0) && *0x2::table::borrow<MintKey, u64>(&arg0.minted_per_wallet, v0) > 0 || arg1 == arg0.active_phase
    }

    fun phase_open_key(arg0: u64) : MintKey {
        MintKey{
            phase : arg0,
            who   : @0x0,
        }
    }

    public fun pool_piece_of(arg0: &RerollPool, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.rerolled, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.rerolled, arg1)
        } else {
            0
        }
    }

    public fun provenance_hash(arg0: &Provenance) : vector<u8> {
        arg0.hash
    }

    public fun provenance_scheme(arg0: &Provenance) : 0x1::string::String {
        arg0.scheme
    }

    entry fun public_mint_box_many(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seeded == arg1.size, 11);
        assert!(arg1.minted + arg3 <= arg1.size, 8);
        let v0 = charge_and_check(arg0, arg2, arg3, arg4);
        let v1 = 0;
        while (v1 < arg3) {
            arg1.minted = arg1.minted + 1;
            let v2 = arg1.minted;
            let v3 = Punk{
                id         : 0x2::object::new(arg4),
                number     : v2,
                index      : 0,
                attributes : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            };
            let v4 = PunkMinted{
                object_id : 0x2::object::id<Punk>(&v3),
                number    : v2,
                index     : 0,
                recipient : v0,
            };
            0x2::event::emit<PunkMinted>(v4);
            0x2::transfer::public_transfer<Punk>(v3, v0);
            v1 = v1 + 1;
        };
    }

    entry fun public_mint_box_many_in_phase(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seeded == arg1.size, 11);
        assert!(arg1.minted + arg4 <= arg1.size, 8);
        let v0 = charge_and_check_for_phase(arg0, arg2, arg3, arg4, arg5);
        let v1 = 0;
        while (v1 < arg4) {
            arg1.minted = arg1.minted + 1;
            let v2 = arg1.minted;
            let v3 = Punk{
                id         : 0x2::object::new(arg5),
                number     : v2,
                index      : 0,
                attributes : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            };
            let v4 = PunkMinted{
                object_id : 0x2::object::id<Punk>(&v3),
                number    : v2,
                index     : 0,
                recipient : v0,
            };
            0x2::event::emit<PunkMinted>(v4);
            0x2::transfer::public_transfer<Punk>(v3, v0);
            v1 = v1 + 1;
        };
    }

    entry fun public_mint_many(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seeded == arg1.size, 11);
        assert!(arg1.remaining >= arg3, 8);
        let v0 = charge_and_check(arg0, arg2, arg3, arg5);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = &mut v1;
        draw_and_mint(arg1, arg3, v0, v2, arg5);
    }

    entry fun public_mint_many_in_phase(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seeded == arg1.size, 11);
        assert!(arg1.remaining >= arg4, 8);
        let v0 = charge_and_check_for_phase(arg0, arg2, arg3, arg4, arg6);
        let v1 = 0x2::random::new_generator(arg5, arg6);
        let v2 = &mut v1;
        draw_and_mint(arg1, arg4, v0, v2, arg6);
    }

    public fun push_phase(arg0: &AdminCap, arg1: &mut MintConfig, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u64) {
        let v0 = Phase{
            name           : 0x1::string::utf8(arg2),
            price          : arg3,
            gated          : arg4,
            max_per_wallet : arg5,
        };
        0x1::vector::push_back<Phase>(&mut arg1.phases, v0);
    }

    public fun remaining(arg0: &Collection) : u64 {
        arg0.remaining
    }

    public fun remove_from_allowlist(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.allowlist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.allowlist, arg2);
        };
    }

    entry fun reroll(arg0: &mut RerollPool, arg1: &mut Punk, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        reroll_apply(arg0, arg1, arg2, arg3, arg4);
    }

    fun reroll_apply(arg0: &mut RerollPool, arg1: &mut Punk, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 18);
        assert!(arg0.seeded == arg0.size, 11);
        assert!(arg0.remaining > 0, 19);
        assert!(arg1.index != 0, 20);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.price, 21);
        if (arg0.price > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.price, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = &mut v0;
        let v2 = draw_pool(arg0, v1);
        arg1.attributes = 0x2::table::remove<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0.registry, v2);
        let v3 = arg1.index;
        let v4 = v2 + 1;
        if (0x2::table::contains<u64, u64>(&arg0.rerolled, v3)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.rerolled, v3) = v4;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.rerolled, v3, v4);
        };
        let v5 = PunkRerolled{
            object_id  : 0x2::object::id<Punk>(arg1),
            number     : arg1.number,
            index      : v3,
            pool_piece : v4,
            owner      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PunkRerolled>(v5);
    }

    public fun reroll_is_open(arg0: &RerollPool) : bool {
        arg0.is_open
    }

    entry fun reroll_kiosk(arg0: &mut RerollPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<Punk>(arg1, arg2, arg3);
        let v2 = v0;
        let v3 = &mut v2;
        reroll_apply(arg0, v3, arg4, arg5, arg6);
        0x2::kiosk::return_val<Punk>(arg1, v2, v1);
    }

    entry fun reroll_personal_kiosk(arg0: &mut RerollPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<Punk>(arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3);
        let v2 = v0;
        let v3 = &mut v2;
        reroll_apply(arg0, v3, arg4, arg5, arg6);
        0x2::kiosk::return_val<Punk>(arg1, v2, v1);
    }

    public fun reroll_price(arg0: &RerollPool) : u64 {
        arg0.price
    }

    public fun reroll_remaining(arg0: &RerollPool) : u64 {
        arg0.remaining
    }

    public fun reroll_seeded(arg0: &RerollPool) : u64 {
        arg0.seeded
    }

    public fun reroll_size(arg0: &RerollPool) : u64 {
        arg0.size
    }

    entry fun reveal(arg0: &mut Collection, arg1: &mut Punk, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = &mut v0;
        reveal_inner(arg0, arg1, v1, arg3);
    }

    fun reveal_inner(arg0: &mut Collection, arg1: &mut Punk, arg2: &mut 0x2::random::RandomGenerator, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.index == 0, 14);
        assert!(arg0.remaining > 0, 15);
        let v0 = draw_index(arg0, arg2);
        assert!(0x2::table::contains<u64, PunkData>(&arg0.registry, v0), 13);
        let PunkData { attributes: v1 } = 0x2::table::remove<u64, PunkData>(&mut arg0.registry, v0);
        arg1.index = v0 + 1;
        arg1.attributes = v1;
        let v2 = PunkRevealed{
            object_id : 0x2::object::id<Punk>(arg1),
            number    : arg1.number,
            index     : arg1.index,
            owner     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PunkRevealed>(v2);
    }

    entry fun reveal_many(arg0: &mut Collection, arg1: vector<Punk>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Punk>(&arg1);
        assert!(v0 > 0, 4);
        assert!(v0 <= 20, 6);
        assert!(arg0.remaining >= v0, 15);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        while (!0x1::vector::is_empty<Punk>(&arg1)) {
            let v2 = 0x1::vector::pop_back<Punk>(&mut arg1);
            let v3 = &mut v2;
            let v4 = &mut v1;
            reveal_inner(arg0, v3, v4, arg3);
            0x2::transfer::public_transfer<Punk>(v2, 0x2::tx_context::sender(arg3));
        };
        0x1::vector::destroy_empty<Punk>(arg1);
    }

    public fun seed_correction(arg0: &AdminCap, arg1: &mut Corrections, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 12);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v1)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)));
            v1 = v1 + 1;
        };
        if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.fixes, arg2)) {
            *0x2::table::borrow_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.fixes, arg2) = v0;
        } else {
            0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.fixes, arg2, v0);
        };
    }

    public fun seed_punk(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) {
        assert!(arg2 < arg1.size, 9);
        assert!(!0x2::table::contains<u64, PunkData>(&arg1.registry, arg2), 10);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 12);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v1)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)));
            v1 = v1 + 1;
        };
        let v2 = PunkData{attributes: v0};
        0x2::table::add<u64, PunkData>(&mut arg1.registry, arg2, v2);
        arg1.seeded = arg1.seeded + 1;
    }

    public fun seed_punks_batch(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 12);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<vector<u8>>(&arg5), 12);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v3 < arg1.size, 9);
            assert!(!0x2::table::contains<u64, PunkData>(&arg1.registry, v3), 10);
            let v5 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v6 = 0;
            while (v6 < v4) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v2 + v6)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg5, v2 + v6)));
                v6 = v6 + 1;
            };
            let v7 = PunkData{attributes: v5};
            0x2::table::add<u64, PunkData>(&mut arg1.registry, v3, v7);
            arg1.seeded = arg1.seeded + 1;
            v2 = v2 + v4;
            v1 = v1 + 1;
        };
        assert!(v2 == 0x1::vector::length<vector<u8>>(&arg4), 12);
    }

    public fun seed_reroll_batch(arg0: &AdminCap, arg1: &mut RerollPool, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 12);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<vector<u8>>(&arg5), 12);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v3 < arg1.size, 9);
            assert!(!0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.registry, v3), 10);
            let v5 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v6 = 0;
            while (v6 < v4) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v2 + v6)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg5, v2 + v6)));
                v6 = v6 + 1;
            };
            0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.registry, v3, v5);
            arg1.seeded = arg1.seeded + 1;
            v2 = v2 + v4;
            v1 = v1 + 1;
        };
        assert!(v2 == 0x1::vector::length<vector<u8>>(&arg4), 12);
    }

    public fun seeded(arg0: &Collection) : u64 {
        arg0.seeded
    }

    public fun set_active_phase(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 5);
        arg1.active_phase = arg2;
    }

    public fun set_open(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun set_phase_open(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: bool) {
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 5);
        let v0 = phase_open_key(arg2);
        let v1 = if (arg3) {
            1
        } else {
            0
        };
        if (0x2::table::contains<MintKey, u64>(&arg1.minted_per_wallet, v0)) {
            *0x2::table::borrow_mut<MintKey, u64>(&mut arg1.minted_per_wallet, v0) = v1;
        } else {
            0x2::table::add<MintKey, u64>(&mut arg1.minted_per_wallet, v0, v1);
        };
    }

    public fun set_phase_params(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: u64, arg4: bool, arg5: u64) {
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 5);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        v0.price = arg3;
        v0.gated = arg4;
        v0.max_per_wallet = arg5;
    }

    public fun set_reroll_open(arg0: &AdminCap, arg1: &mut RerollPool, arg2: bool) {
        assert!(arg1.seeded == arg1.size, 11);
        arg1.is_open = arg2;
    }

    public fun set_reroll_price(arg0: &AdminCap, arg1: &mut RerollPool, arg2: u64) {
        arg1.price = arg2;
    }

    public fun set_reroll_treasury(arg0: &AdminCap, arg1: &mut RerollPool, arg2: address) {
        assert!(arg2 != @0x0, 7);
        arg1.treasury = arg2;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        assert!(arg2 != @0x0, 7);
        arg1.treasury = arg2;
    }

    public fun size(arg0: &Collection) : u64 {
        arg0.size
    }

    public fun treasury(arg0: &MintConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

