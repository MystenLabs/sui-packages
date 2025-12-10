module 0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::suikamon {
    struct SUIKAMON has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BackendCap has store, key {
        id: 0x2::object::UID,
        backend_address: address,
        epoch: u64,
    }

    struct EvolutionToken has store, key {
        id: 0x2::object::UID,
        suikamon_id: address,
        new_level: u16,
        new_stage: u8,
        new_image: 0x1::string::String,
    }

    struct SuikamonRegistry has key {
        id: 0x2::object::UID,
        total_minted: u64,
        minted_by_species: 0x2::table::Table<u8, u64>,
        backend_epoch: u64,
        version: u64,
    }

    struct Suikamon has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        species: u8,
        rarity: u8,
        rarity_name: 0x1::string::String,
        stage: u8,
        level: u16,
        birth_time: u64,
        mint_number: u64,
        version: u64,
    }

    struct SuikamonMintedEvent has copy, drop {
        suikamon_id: address,
        owner: address,
        species: u8,
        rarity: u8,
        mint_number: u64,
        name: 0x1::string::String,
        timestamp: u64,
    }

    struct SuikamonEvolvedEvent has copy, drop {
        suikamon_id: address,
        owner: address,
        old_stage: u8,
        new_stage: u8,
        old_level: u16,
        new_level: u16,
        timestamp: u64,
    }

    struct EvolutionTokenCreatedEvent has copy, drop {
        token_id: address,
        suikamon_id: address,
        recipient: address,
        new_level: u16,
        new_stage: u8,
        timestamp: u64,
    }

    struct SuikamonRenamedEvent has copy, drop {
        suikamon_id: address,
        owner: address,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        timestamp: u64,
    }

    struct SuikamonResetEvent has copy, drop {
        suikamon_id: address,
        owner: address,
        old_stage: u8,
        old_level: u16,
        timestamp: u64,
    }

    public fun admin_bump_display_version(arg0: &AdminCap, arg1: &mut 0x2::display::Display<Suikamon>) {
        0x2::display::update_version<Suikamon>(arg1);
    }

    public fun collection_creator(arg0: &0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection) : address {
        0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::creator(arg0)
    }

    public fun collection_description(arg0: &0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection) : 0x1::string::String {
        0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::description(arg0)
    }

    public fun collection_external_url(arg0: &0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection) : 0x1::string::String {
        0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::external_url(arg0)
    }

    public fun collection_image_url(arg0: &0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection) : 0x1::string::String {
        0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::image_url(arg0)
    }

    public fun collection_name(arg0: &0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection) : 0x1::string::String {
        0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::name(arg0)
    }

    public fun create_backend_cap(arg0: &mut SuikamonRegistry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.backend_epoch = arg0.backend_epoch + 1;
        let v0 = BackendCap{
            id              : 0x2::object::new(arg3),
            backend_address : arg2,
            epoch           : arg0.backend_epoch,
        };
        0x2::transfer::public_transfer<BackendCap>(v0, arg2);
    }

    public fun create_evolution_token(arg0: &SuikamonRegistry, arg1: &BackendCap, arg2: address, arg3: address, arg4: u16, arg5: u8, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 8);
        assert!(arg1.backend_address == 0x2::tx_context::sender(arg8), 6);
        assert!(arg1.epoch == arg0.backend_epoch, 7);
        let v0 = 0x2::object::new(arg8);
        let v1 = EvolutionToken{
            id          : v0,
            suikamon_id : arg2,
            new_level   : arg4,
            new_stage   : arg5,
            new_image   : arg6,
        };
        let v2 = EvolutionTokenCreatedEvent{
            token_id    : 0x2::object::uid_to_address(&v0),
            suikamon_id : arg2,
            recipient   : arg3,
            new_level   : arg4,
            new_stage   : arg5,
            timestamp   : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<EvolutionTokenCreatedEvent>(v2);
        0x2::transfer::public_transfer<EvolutionToken>(v1, arg3);
    }

    public fun get_birth_time(arg0: &Suikamon) : u64 {
        arg0.birth_time
    }

    public fun get_collection_id(arg0: &Suikamon) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun get_description(arg0: &Suikamon) : 0x1::string::String {
        arg0.description
    }

    public fun get_image_url(arg0: &Suikamon) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_level(arg0: &Suikamon) : u16 {
        arg0.level
    }

    public fun get_mint_number(arg0: &Suikamon) : u64 {
        arg0.mint_number
    }

    public fun get_minted_by_species(arg0: &SuikamonRegistry, arg1: u8) : u64 {
        if (0x2::table::contains<u8, u64>(&arg0.minted_by_species, arg1)) {
            *0x2::table::borrow<u8, u64>(&arg0.minted_by_species, arg1)
        } else {
            0
        }
    }

    public fun get_name(arg0: &Suikamon) : 0x1::string::String {
        arg0.name
    }

    public fun get_rarity(arg0: &Suikamon) : u8 {
        arg0.rarity
    }

    public fun get_rarity_name(arg0: &Suikamon) : 0x1::string::String {
        arg0.rarity_name
    }

    fun get_rarity_supply_cap(arg0: u8) : u64 {
        if (arg0 == 0) {
            500
        } else if (arg0 == 1) {
            100
        } else if (arg0 == 2) {
            50
        } else if (arg0 == 3) {
            10
        } else if (arg0 == 4) {
            1
        } else {
            0
        }
    }

    public fun get_registry_version(arg0: &SuikamonRegistry) : u64 {
        arg0.version
    }

    public fun get_species(arg0: &Suikamon) : u8 {
        arg0.species
    }

    public fun get_stage(arg0: &Suikamon) : u8 {
        arg0.stage
    }

    public fun get_total_minted(arg0: &SuikamonRegistry) : u64 {
        arg0.total_minted
    }

    public fun get_version(arg0: &Suikamon) : u64 {
        arg0.version
    }

    fun init(arg0: SUIKAMON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIKAMON>(arg0, arg1);
        let (v1, v2) = 0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::new(0x2::tx_context::sender(arg1), 0x1::string::utf8(b"Suikamon"), 0x1::string::utf8(b"Suikamon - NFT creatures living on the Sui blockchain"), 0x1::string::utf8(b"https://www.suikamon.com"), 0x1::string::utf8(b"https://www.suikamon.com/nft/collection.png"), arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"animation_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"species"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"rarity_name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"stage"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"birth_time"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"mint_number"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Suikamon #{mint_number} - {name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://www.suikamon.com/suikamon/{id}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://www.suikamon.com"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Suikamon"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{species}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{rarity_name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{stage}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{birth_time}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{mint_number}"));
        let v7 = 0x2::display::new_with_fields<Suikamon>(&v0, v3, v5, arg1);
        0x2::display::update_version<Suikamon>(&mut v7);
        let (v8, v9) = 0x2::transfer_policy::new<Suikamon>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Suikamon>>(v8);
        0x2::transfer::public_transfer<0x2::display::Display<Suikamon>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Suikamon>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollectionAdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection>(v1);
        let v10 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v10, 0x2::tx_context::sender(arg1));
        let v11 = SuikamonRegistry{
            id                : 0x2::object::new(arg1),
            total_minted      : 0,
            minted_by_species : 0x2::table::new<u8, u64>(arg1),
            backend_epoch     : 0,
            version           : 1,
        };
        0x2::transfer::share_object<SuikamonRegistry>(v11);
    }

    public fun migrate_registry_version(arg0: &mut SuikamonRegistry, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 > arg0.version, 9);
        arg0.version = arg2;
    }

    public fun migrate_suikamon_version(arg0: &mut Suikamon, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 > arg0.version, 9);
        arg0.version = arg2;
    }

    public fun mint_suikamon(arg0: &mut SuikamonRegistry, arg1: &BackendCap, arg2: &0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u8, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 8);
        assert!(arg1.backend_address == 0x2::tx_context::sender(arg10), 6);
        assert!(arg1.epoch == arg0.backend_epoch, 7);
        assert!(arg7 <= 4, 1);
        if (!0x2::table::contains<u8, u64>(&arg0.minted_by_species, arg6)) {
            0x2::table::add<u8, u64>(&mut arg0.minted_by_species, arg6, 0);
        };
        let v0 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.minted_by_species, arg6);
        assert!(*v0 < get_rarity_supply_cap(arg7), 2);
        *v0 = *v0 + 1;
        let v1 = arg0.total_minted + 1;
        arg0.total_minted = arg0.total_minted + 1;
        let v2 = 0x2::object::new(arg10);
        let v3 = 0x2::clock::timestamp_ms(arg9);
        let v4 = Suikamon{
            id            : v2,
            collection_id : 0x2::object::id<0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection::SuikamonCollection>(arg2),
            name          : arg3,
            description   : arg4,
            image_url     : arg5,
            species       : arg6,
            rarity        : arg7,
            rarity_name   : rarity_name_from(arg7),
            stage         : 0,
            level         : 1,
            birth_time    : v3,
            mint_number   : v1,
            version       : 1,
        };
        let v5 = SuikamonMintedEvent{
            suikamon_id : 0x2::object::uid_to_address(&v2),
            owner       : arg8,
            species     : arg6,
            rarity      : arg7,
            mint_number : v1,
            name        : arg3,
            timestamp   : v3,
        };
        0x2::event::emit<SuikamonMintedEvent>(v5);
        0x2::transfer::public_transfer<Suikamon>(v4, arg8);
    }

    fun rarity_name_from(arg0: u8) : 0x1::string::String {
        assert!(arg0 <= 4, 1);
        if (arg0 == 0) {
            0x1::string::utf8(b"Common")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Rare")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Epic")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Legendary")
        } else {
            0x1::string::utf8(b"Unique")
        }
    }

    entry fun rename_suikamon(arg0: &mut Suikamon, arg1: &BackendCap, arg2: &SuikamonRegistry, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.backend_address == 0x2::tx_context::sender(arg5), 6);
        assert!(arg1.epoch == arg2.backend_epoch, 7);
        arg0.name = arg3;
        let v0 = SuikamonRenamedEvent{
            suikamon_id : 0x2::object::uid_to_address(&arg0.id),
            owner       : 0x2::tx_context::sender(arg5),
            old_name    : arg0.name,
            new_name    : arg3,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SuikamonRenamedEvent>(v0);
    }

    entry fun reset_suikamon_to_egg(arg0: &mut Suikamon, arg1: &BackendCap, arg2: &SuikamonRegistry, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.backend_address == 0x2::tx_context::sender(arg5), 6);
        assert!(arg1.epoch == arg2.backend_epoch, 7);
        arg0.stage = 0;
        arg0.level = 1;
        arg0.image_url = arg3;
        let v0 = SuikamonResetEvent{
            suikamon_id : 0x2::object::uid_to_address(&arg0.id),
            owner       : 0x2::tx_context::sender(arg5),
            old_stage   : arg0.stage,
            old_level   : arg0.level,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SuikamonResetEvent>(v0);
    }

    entry fun use_evolution_token(arg0: &mut Suikamon, arg1: EvolutionToken, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        assert!(arg1.suikamon_id == v0, 3);
        let EvolutionToken {
            id          : v1,
            suikamon_id : _,
            new_level   : v3,
            new_stage   : v4,
            new_image   : v5,
        } = arg1;
        assert!(v3 >= arg0.level, 4);
        assert!(v4 >= arg0.stage, 5);
        arg0.level = v3;
        arg0.stage = v4;
        arg0.image_url = v5;
        let v6 = SuikamonEvolvedEvent{
            suikamon_id : v0,
            owner       : 0x2::tx_context::sender(arg3),
            old_stage   : arg0.stage,
            new_stage   : v4,
            old_level   : arg0.level,
            new_level   : v3,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SuikamonEvolvedEvent>(v6);
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

