module 0x86a033312e29d225ce7c5086520f56c001ce6483db2a6c29c1ac8f172e4683a6::passport {
    struct PASSPORT has drop {
        dummy_field: bool,
    }

    struct QTConfiguration has store, key {
        id: 0x2::object::UID,
        passport_max_level: u64,
        public_key: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PassportSupply has store, key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
    }

    struct Passport has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        level: u64,
        color: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct PassportMetadata has drop, store {
        id: 0x2::object::ID,
        status: bool,
        upgradable: bool,
    }

    struct PassportArchive has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, PassportMetadata>,
    }

    struct PassportCounter has store, key {
        id: 0x2::object::UID,
    }

    struct CounterKey has copy, drop, store {
        color: 0x1::string::String,
        level: u64,
    }

    public fun admin_add_counter(arg0: &AdminCap, arg1: &mut PassportCounter, arg2: 0x1::string::String, arg3: u64) {
        let v0 = CounterKey{
            color : arg2,
            level : arg3,
        };
        assert!(!0x2::dynamic_field::exists_<CounterKey>(&arg1.id, v0), 8);
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg1.id, v0, 0);
    }

    public fun admin_add_passport_to_archive(arg0: &AdminCap, arg1: &mut PassportArchive, arg2: address, arg3: 0x2::object::ID, arg4: bool, arg5: bool) {
        assert!(!has_passport(arg1, arg2), 2);
        let v0 = PassportMetadata{
            id         : arg3,
            status     : arg4,
            upgradable : arg5,
        };
        0x2::table::add<address, PassportMetadata>(&mut arg1.users, arg2, v0);
    }

    public fun admin_mint_passport(arg0: &AdminCap, arg1: &mut PassportArchive, arg2: &mut PassportCounter, arg3: &mut PassportSupply, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!has_passport(arg1, arg9), 2);
        let v0 = Passport{
            id          : 0x2::object::new(arg10),
            name        : arg4,
            description : arg5,
            level       : arg6,
            color       : arg7,
            image_url   : arg8,
        };
        admin_add_passport_to_archive(arg0, arg1, arg9, 0x2::object::uid_to_inner(&v0.id), true, false);
        increment_counter(arg2, arg7, arg6);
        if (arg7 == 0x1::string::utf8(b"early_bird")) {
            if (arg3.total_minted == arg3.max_supply) {
                abort 11
            };
            arg3.total_minted = arg3.total_minted + 1;
        };
        0x2::transfer::transfer<Passport>(v0, arg9);
    }

    public fun admin_modify_supply(arg0: &AdminCap, arg1: &mut PassportSupply, arg2: u64) {
        assert!(arg2 > arg1.total_minted, 12);
        arg1.max_supply = arg2;
    }

    public fun admin_remove_counter(arg0: &AdminCap, arg1: &mut PassportCounter, arg2: 0x1::string::String, arg3: u64) {
        let v0 = CounterKey{
            color : arg2,
            level : arg3,
        };
        assert!(0x2::dynamic_field::exists_<CounterKey>(&arg1.id, v0), 6);
        0x2::dynamic_field::remove<CounterKey, u64>(&mut arg1.id, v0);
    }

    public fun admin_remove_passport_from_archive(arg0: &AdminCap, arg1: &mut PassportArchive, arg2: address) {
        assert!(has_passport(arg1, arg2), 3);
        0x2::table::remove<address, PassportMetadata>(&mut arg1.users, arg2);
    }

    public fun admin_update_passport_status_in_archive(arg0: &AdminCap, arg1: &mut PassportArchive, arg2: address, arg3: bool) {
        assert!(has_passport(arg1, arg2), 3);
        0x2::table::borrow_mut<address, PassportMetadata>(&mut arg1.users, arg2).status = arg3;
    }

    public fun admin_update_passport_upgradability_in_archive(arg0: &AdminCap, arg1: &mut PassportArchive, arg2: address, arg3: bool) {
        assert!(has_passport(arg1, arg2), 3);
        0x2::table::borrow_mut<address, PassportMetadata>(&mut arg1.users, arg2).upgradable = arg3;
    }

    public fun change_passport_max_level(arg0: &AdminCap, arg1: &mut QTConfiguration, arg2: u64) {
        arg1.passport_max_level = arg2;
    }

    public fun create_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    fun decrement_counter(arg0: &mut PassportCounter, arg1: 0x1::string::String, arg2: u64) {
        let v0 = CounterKey{
            color : arg1,
            level : arg2,
        };
        assert!(0x2::dynamic_field::exists_<CounterKey>(&arg0.id, v0), 6);
        let v1 = 0x2::dynamic_field::borrow_mut<CounterKey, u64>(&mut arg0.id, v0);
        assert!(*v1 > 0, 7);
        *v1 = *v1 - 1;
    }

    public fun get_counter_value(arg0: &PassportCounter, arg1: 0x1::string::String, arg2: u64) : u64 {
        let v0 = CounterKey{
            color : arg1,
            level : arg2,
        };
        assert!(0x2::dynamic_field::exists_<CounterKey>(&arg0.id, v0), 6);
        *0x2::dynamic_field::borrow<CounterKey, u64>(&arg0.id, v0)
    }

    public fun get_max_supply(arg0: &PassportSupply) : u64 {
        arg0.max_supply
    }

    public fun get_passport_id_from_archive(arg0: &PassportArchive, arg1: address) : 0x2::object::ID {
        assert!(has_passport(arg0, arg1), 3);
        0x2::table::borrow<address, PassportMetadata>(&arg0.users, arg1).id
    }

    public fun get_total_minted(arg0: &PassportSupply) : u64 {
        arg0.total_minted
    }

    public fun has_passport(arg0: &PassportArchive, arg1: address) : bool {
        0x2::table::contains<address, PassportMetadata>(&arg0.users, arg1)
    }

    public fun id(arg0: &Passport) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun increment_counter(arg0: &mut PassportCounter, arg1: 0x1::string::String, arg2: u64) {
        let v0 = CounterKey{
            color : arg1,
            level : arg2,
        };
        if (0x2::dynamic_field::exists_<CounterKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<CounterKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v0, 1);
        };
    }

    fun init(arg0: PASSPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PASSPORT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"color"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{color}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://quantumtemple.xyz/"));
        let v5 = 0x2::display::new_with_fields<Passport>(&v0, v1, v3, arg1);
        let v6 = PassportSupply{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            max_supply   : 1000,
        };
        0x2::display::update_version<Passport>(&mut v5);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        let v8 = QTConfiguration{
            id                 : 0x2::object::new(arg1),
            passport_max_level : 3,
            public_key         : 0x1::vector::empty<u8>(),
        };
        let v9 = PassportArchive{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, PassportMetadata>(arg1),
        };
        let v10 = PassportCounter{id: 0x2::object::new(arg1)};
        let v11 = &mut v10;
        initialize_counter_values(v11);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Passport>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<QTConfiguration>(v8);
        0x2::transfer::share_object<PassportArchive>(v9);
        0x2::transfer::share_object<PassportCounter>(v10);
        0x2::transfer::share_object<PassportSupply>(v6);
    }

    fun initialize_counter_values(arg0: &mut PassportCounter) {
        let v0 = CounterKey{
            color : 0x1::string::utf8(b"early_bird"),
            level : 1,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v0, 0);
        let v1 = CounterKey{
            color : 0x1::string::utf8(b"early_bird"),
            level : 2,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v1, 0);
        let v2 = CounterKey{
            color : 0x1::string::utf8(b"early_bird"),
            level : 3,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v2, 0);
        let v3 = CounterKey{
            color : 0x1::string::utf8(b"early_bird"),
            level : 4,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v3, 0);
        let v4 = CounterKey{
            color : 0x1::string::utf8(b"early_bird"),
            level : 5,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v4, 0);
        let v5 = CounterKey{
            color : 0x1::string::utf8(b"ambassador_passport"),
            level : 1,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v5, 0);
        let v6 = CounterKey{
            color : 0x1::string::utf8(b"ambassador_passport"),
            level : 2,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v6, 0);
        let v7 = CounterKey{
            color : 0x1::string::utf8(b"ambassador_passport"),
            level : 3,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v7, 0);
        let v8 = CounterKey{
            color : 0x1::string::utf8(b"ambassador_passport"),
            level : 4,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v8, 0);
        let v9 = CounterKey{
            color : 0x1::string::utf8(b"ambassador_passport"),
            level : 5,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v9, 0);
        let v10 = CounterKey{
            color : 0x1::string::utf8(b"standard_passport"),
            level : 1,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v10, 0);
        let v11 = CounterKey{
            color : 0x1::string::utf8(b"standard_passport"),
            level : 2,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v11, 0);
        let v12 = CounterKey{
            color : 0x1::string::utf8(b"standard_passport"),
            level : 3,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v12, 0);
        let v13 = CounterKey{
            color : 0x1::string::utf8(b"standard_passport"),
            level : 4,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v13, 0);
        let v14 = CounterKey{
            color : 0x1::string::utf8(b"standard_passport"),
            level : 5,
        };
        0x2::dynamic_field::add<CounterKey, u64>(&mut arg0.id, v14, 0);
    }

    public fun is_passport_active(arg0: &PassportArchive, arg1: address) : bool {
        assert!(has_passport(arg0, arg1), 3);
        0x2::table::borrow<address, PassportMetadata>(&arg0.users, arg1).status
    }

    public fun is_passport_upgradable(arg0: &PassportArchive, arg1: address) : bool {
        assert!(has_passport(arg0, arg1), 3);
        0x2::table::borrow<address, PassportMetadata>(&arg0.users, arg1).upgradable
    }

    public fun level(arg0: &Passport) : u64 {
        arg0.level
    }

    public fun set_public_key(arg0: &AdminCap, arg1: &mut QTConfiguration, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun update_passport(arg0: &mut PassportArchive, arg1: &mut PassportCounter, arg2: &mut Passport, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: vector<u8>, arg8: &QTConfiguration, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= arg8.passport_max_level, 5);
        assert!(0x2::clock::timestamp_ms(arg9) <= arg6, 1);
        assert!(is_passport_upgradable(arg0, 0x2::tx_context::sender(arg10)), 4);
        assert!(is_passport_active(arg0, 0x2::tx_context::sender(arg10)), 9);
        assert!(verify_update_signature(0x2::object::uid_to_inner(&arg2.id), arg3, arg4, arg5, arg6, arg7, arg8), 0);
        decrement_counter(arg1, arg2.color, arg2.level);
        increment_counter(arg1, arg4, arg3);
        update_passport_level(arg2, arg3);
        update_passport_color(arg2, arg4, true);
        update_passport_image_url(arg2, arg5, true);
    }

    fun update_passport_color(arg0: &mut Passport, arg1: 0x1::string::String, arg2: bool) {
        if (arg2 || !0x1::string::is_empty(&arg1)) {
            arg0.color = arg1;
        };
    }

    fun update_passport_image_url(arg0: &mut Passport, arg1: 0x1::string::String, arg2: bool) {
        if (arg2 || !0x1::string::is_empty(&arg1)) {
            arg0.image_url = arg1;
        };
    }

    fun update_passport_level(arg0: &mut Passport, arg1: u64) {
        arg0.level = arg1;
    }

    public fun verify_update_signature(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<u8>, arg6: &QTConfiguration) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x2::ed25519::ed25519_verify(&arg5, &arg6.public_key, &v0)
    }

    // decompiled from Move bytecode v6
}

