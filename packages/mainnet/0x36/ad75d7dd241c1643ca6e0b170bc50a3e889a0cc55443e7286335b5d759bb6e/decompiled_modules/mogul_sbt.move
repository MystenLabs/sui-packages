module 0x36ad75d7dd241c1643ca6e0b170bc50a3e889a0cc55443e7286335b5d759bb6e::mogul_sbt {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MogulSBT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_number: u64,
    }

    struct TokenMetadata has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        current_supply: u64,
        max: u64,
        receivers: 0x2::table::Table<address, bool>,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        metadata: 0x2::table::Table<u64, TokenMetadata>,
    }

    struct MintedEvent has copy, drop {
        current_supply: u64,
    }

    struct ConfigUpdatedEvent has copy, drop {
        current_supply: u64,
        max: u64,
    }

    struct MetadataAddedEvent has copy, drop {
        id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
    }

    struct MOGUL_SBT has drop {
        dummy_field: bool,
    }

    public fun add_metadata(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &Version, arg8: &mut 0x2::tx_context::TxContext) {
        validate_version(arg7);
        let v0 = TokenMetadata{
            name           : arg3,
            description    : arg4,
            image_url      : arg5,
            current_supply : 0,
            max            : arg6,
            receivers      : 0x2::table::new<address, bool>(arg8),
        };
        0x2::table::add<u64, TokenMetadata>(&mut arg1.metadata, arg2, v0);
        let v1 = MetadataAddedEvent{
            id          : arg2,
            name        : arg3,
            description : arg4,
            image_url   : arg5,
            max_supply  : arg6,
        };
        0x2::event::emit<MetadataAddedEvent>(v1);
    }

    entry fun admin_freeze(arg0: &AdminCap, arg1: &mut Version) {
        arg1.version = 0;
    }

    public fun get_current_supply(arg0: &Config, arg1: u64) : u64 {
        0x2::table::borrow<u64, TokenMetadata>(&arg0.metadata, arg1).current_supply
    }

    fun init(arg0: MOGUL_SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MOGUL_SBT>(arg0, arg1);
        let v1 = 0x2::display::new<MogulSBT>(&v0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = Config{
            id       : 0x2::object::new(arg1),
            metadata : 0x2::table::new<u64, TokenMetadata>(arg1),
        };
        let v4 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::display::add<MogulSBT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MogulSBT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MogulSBT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<MogulSBT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<MogulSBT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Config>(v3);
        0x2::transfer::public_share_object<Version>(v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1004);
        arg1.version = arg2;
    }

    public fun mint(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        let v0 = 0x2::table::borrow_mut<u64, TokenMetadata>(&mut arg1.metadata, arg2);
        assert!(v0.current_supply < v0.max, 1001);
        assert!(!0x2::table::contains<address, bool>(&v0.receivers, arg3), 1003);
        v0.current_supply = v0.current_supply + 1;
        0x2::table::add<address, bool>(&mut v0.receivers, arg3, true);
        let v1 = MogulSBT{
            id           : 0x2::object::new(arg5),
            name         : v0.name,
            description  : v0.description,
            image_url    : v0.image_url,
            token_number : v0.current_supply,
        };
        0x2::transfer::transfer<MogulSBT>(v1, arg3);
        let v2 = MintedEvent{current_supply: v0.current_supply};
        0x2::event::emit<MintedEvent>(v2);
    }

    public fun update_max_supply(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: &Version) {
        validate_version(arg4);
        let v0 = 0x2::table::borrow_mut<u64, TokenMetadata>(&mut arg1.metadata, arg2);
        assert!(arg3 >= v0.current_supply, 1002);
        assert!(arg3 > 0, 1002);
        v0.max = arg3;
        let v1 = ConfigUpdatedEvent{
            current_supply : v0.current_supply,
            max            : v0.max,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v1);
    }

    fun validate_version(arg0: &Version) {
        assert!(1 == arg0.version, 1004);
    }

    // decompiled from Move bytecode v6
}

