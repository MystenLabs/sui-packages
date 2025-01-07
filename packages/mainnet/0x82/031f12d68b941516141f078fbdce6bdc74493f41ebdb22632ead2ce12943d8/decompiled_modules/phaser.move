module 0x82031f12d68b941516141f078fbdce6bdc74493f41ebdb22632ead2ce12943d8::phaser {
    struct Ticket has copy, drop {
        owner: address,
        amount: u64,
    }

    struct Phaser has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        collection_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        total_supply: u64,
        sender_total_limit: u64,
        sender_per_limit: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        whitelist_merkle_roots: 0x2::table::Table<address, bool>,
        minted_amount: u64,
        user_minted: 0x2::table::Table<address, u64>,
    }

    struct CreatePhaserEvent has copy, drop {
        phaser: 0x2::object::ID,
        collection_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        sender_per_limit: u64,
        sender_total_limit: u64,
        total_supply: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        whitelist_merkle_roots: vector<address>,
    }

    struct ModifyPhaserEvent has copy, drop {
        phaser: 0x2::object::ID,
        price: u64,
        sender_per_limit: u64,
        sender_total_limit: u64,
        total_supply: u64,
        start_time: u64,
        end_time: u64,
    }

    struct SetPhaserStatusEvent has copy, drop {
        phaser: 0x2::object::ID,
        status: u8,
    }

    struct IncrementEvent has copy, drop {
        phaser: 0x2::object::ID,
        account: address,
        mint_count: u64,
    }

    struct AddPhaserWhitelistsEvent has copy, drop {
        phaser: 0x2::object::ID,
        roots: vector<address>,
    }

    struct RemovePhaserWhitelistsEvent has copy, drop {
        phaser: 0x2::object::ID,
        roots: vector<address>,
    }

    struct PHASER has drop {
        dummy_field: bool,
    }

    public fun add_phaser_whitelists(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser, arg2: vector<address>) {
        assert_version(arg1);
        assert_owner(arg0);
        let v0 = &mut arg1.whitelist_merkle_roots;
        let v1 = AddPhaserWhitelistsEvent{
            phaser : 0x2::object::id<Phaser>(arg1),
            roots  : add_whitelists(v0, arg2),
        };
        0x2::event::emit<AddPhaserWhitelistsEvent>(v1);
    }

    fun add_whitelists(arg0: &mut 0x2::table::Table<address, bool>, arg1: vector<address>) : vector<address> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(arg0, v2)) {
                0x1::vector::push_back<address>(&mut v1, v2);
                0x2::table::add<address, bool>(arg0, v2, true);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun assert_coin_type<T0>(arg0: &Phaser) {
        assert!(arg0.coin_type == 0x1::type_name::get<T0>(), 10007);
    }

    public fun assert_collection_type<T0>(arg0: &Phaser) {
        assert!(0x1::type_name::get<T0>() == *borrow_collection_type(arg0), 10014);
    }

    public fun assert_free_price(arg0: &Phaser) {
        assert!(arg0.price == 0, 10006);
    }

    public fun assert_mint_timestamp(arg0: &Phaser, arg1: u64) {
        assert!(arg0.start_time <= arg1 && arg1 < arg0.end_time, 10008);
    }

    fun assert_owner(arg0: &mut 0x2::package::Publisher) {
        assert!(0x2::package::from_package<Phaser>(arg0), 10013);
    }

    public fun assert_payment_price(arg0: &Phaser) {
        assert!(arg0.price > 0, 10006);
    }

    public fun assert_phaser_mint_count(arg0: &Phaser, arg1: address, arg2: u64) {
        assert_phaser_total_supply(arg0, arg2);
        assert_sender_per_mint_amount(arg0, arg2);
        assert_sender_total_limit(arg0, get_user_minted_amount(arg0, arg1), arg2);
    }

    public fun assert_phaser_opened(arg0: &Phaser) {
        assert!(arg0.status == 1, 10005);
    }

    public fun assert_phaser_status(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1 || arg0 == 2, 10003);
    }

    public fun assert_phaser_total_supply(arg0: &Phaser, arg1: u64) {
        assert!(arg0.minted_amount + arg1 <= arg0.total_supply, 10009);
    }

    public fun assert_phaser_whitelist_opened(arg0: &Phaser) {
        assert!(arg0.status == 2, 10005);
    }

    public fun assert_sender_per_mint_amount(arg0: &Phaser, arg1: u64) {
        assert!(arg1 <= arg0.sender_per_limit, 10010);
    }

    public fun assert_sender_total_limit(arg0: &Phaser, arg1: u64, arg2: u64) {
        assert!(arg1 + arg2 <= arg0.sender_total_limit, 10011);
    }

    public fun assert_total_supply(arg0: &Phaser, arg1: u64) {
        assert!(arg0.minted_amount <= arg1, 10012);
    }

    fun assert_version(arg0: &Phaser) {
        assert!(arg0.version == 1, 10001);
    }

    public fun assert_whitelist_merkle_root(arg0: &Phaser, arg1: address, arg2: u64, arg3: vector<address>) {
        assert!(0x2::table::contains<address, bool>(&arg0.whitelist_merkle_roots, generate_merkle_root(arg1, arg2, arg3)), 10004);
    }

    public fun borrow_coin_type(arg0: &Phaser) : &0x1::type_name::TypeName {
        &arg0.coin_type
    }

    public fun borrow_collection_type(arg0: &Phaser) : &0x1::type_name::TypeName {
        &arg0.collection_type
    }

    public fun borrow_end_time(arg0: &Phaser) : &u64 {
        &arg0.end_time
    }

    public fun borrow_minted_amount(arg0: &Phaser) : &u64 {
        &arg0.minted_amount
    }

    public fun borrow_mut_coin_type(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut 0x1::type_name::TypeName {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.coin_type
    }

    public fun borrow_mut_collection_type(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut 0x1::type_name::TypeName {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.collection_type
    }

    public fun borrow_mut_end_time(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u64 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.end_time
    }

    public fun borrow_mut_minted_amount(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u64 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.minted_amount
    }

    public fun borrow_mut_name(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut 0x1::string::String {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.name
    }

    public fun borrow_mut_price(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u64 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.price
    }

    public fun borrow_mut_sender_per_limit(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u64 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.sender_per_limit
    }

    public fun borrow_mut_sender_total_limit(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u64 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.sender_total_limit
    }

    public fun borrow_mut_start_time(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u64 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.start_time
    }

    public fun borrow_mut_status(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u8 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.status
    }

    public fun borrow_mut_total_supply(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut u64 {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.total_supply
    }

    public fun borrow_mut_uid(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut 0x2::object::UID {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.id
    }

    public fun borrow_mut_user_minted(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut 0x2::table::Table<address, u64> {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.user_minted
    }

    public fun borrow_mut_whitelist_merkle_roots(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) : &mut 0x2::table::Table<address, bool> {
        assert_version(arg1);
        assert_owner(arg0);
        &mut arg1.whitelist_merkle_roots
    }

    public fun borrow_name(arg0: &Phaser) : &0x1::string::String {
        &arg0.name
    }

    public fun borrow_price(arg0: &Phaser) : &u64 {
        &arg0.price
    }

    public fun borrow_sender_per_limit(arg0: &Phaser) : &u64 {
        &arg0.sender_per_limit
    }

    public fun borrow_sender_total_limit(arg0: &Phaser) : &u64 {
        &arg0.sender_total_limit
    }

    public fun borrow_start_time(arg0: &Phaser) : &u64 {
        &arg0.start_time
    }

    public fun borrow_status(arg0: &Phaser) : &u8 {
        &arg0.status
    }

    public fun borrow_total_supply(arg0: &Phaser) : &u64 {
        &arg0.total_supply
    }

    public fun borrow_uid(arg0: &Phaser) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_user_minted(arg0: &Phaser) : &0x2::table::Table<address, u64> {
        &arg0.user_minted
    }

    public fun borrow_version(arg0: &Phaser) : &u64 {
        &arg0.version
    }

    public fun borrow_whitelist_merkle_roots(arg0: &Phaser) : &0x2::table::Table<address, bool> {
        &arg0.whitelist_merkle_roots
    }

    public fun contains_whitelist(arg0: &Phaser, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist_merkle_roots, arg1)
    }

    public fun create_phaser(arg0: &mut 0x2::package::Publisher, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: vector<address>, arg11: &mut 0x2::tx_context::TxContext) : Phaser {
        assert_phaser_status(arg9);
        assert_owner(arg0);
        let v0 = Phaser{
            id                     : 0x2::object::new(arg11),
            version                : 1,
            name                   : 0x1::string::utf8(b"phaser"),
            collection_type        : arg1,
            coin_type              : arg2,
            price                  : arg3,
            total_supply           : arg6,
            sender_total_limit     : arg5,
            sender_per_limit       : arg4,
            start_time             : arg7,
            end_time               : arg8,
            status                 : arg9,
            whitelist_merkle_roots : 0x2::table::new<address, bool>(arg11),
            minted_amount          : 0,
            user_minted            : 0x2::table::new<address, u64>(arg11),
        };
        if (0x1::vector::length<address>(&arg10) > 0) {
            let v1 = &mut v0.whitelist_merkle_roots;
            add_whitelists(v1, arg10);
        };
        let v2 = CreatePhaserEvent{
            phaser                 : 0x2::object::id<Phaser>(&v0),
            collection_type        : arg1,
            coin_type              : arg2,
            price                  : v0.price,
            sender_per_limit       : v0.sender_per_limit,
            sender_total_limit     : v0.sender_total_limit,
            total_supply           : v0.total_supply,
            start_time             : v0.start_time,
            end_time               : v0.end_time,
            status                 : arg9,
            whitelist_merkle_roots : arg10,
        };
        0x2::event::emit<CreatePhaserEvent>(v2);
        v0
    }

    fun generate_merkle_root(arg0: address, arg1: u64, arg2: vector<address>) : address {
        let v0 = Ticket{
            owner  : arg0,
            amount : arg1,
        };
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::address::to_bytes(*0x1::vector::borrow<address>(&arg2, v2)));
            v2 = v2 + 1;
        };
        0x2::address::from_bytes(0x74009bf460b51d87a2742f58bbd761bb55419621d0e5e3b4ba7978a8f0a66db1::merkle_proof::process_proof(&v1, 0x1::hash::sha2_256(0x1::bcs::to_bytes<Ticket>(&v0))))
    }

    public fun get_user_minted_amount(arg0: &Phaser, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_minted, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_minted, arg1)
        } else {
            0
        }
    }

    public fun increment(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser, arg2: address, arg3: u64) {
        assert_version(arg1);
        assert_owner(arg0);
        arg1.minted_amount = arg1.minted_amount + arg3;
        if (0x2::table::contains<address, u64>(&arg1.user_minted, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.user_minted, arg2);
            *v0 = *v0 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg1.user_minted, arg2, arg3);
        };
        let v1 = IncrementEvent{
            phaser     : 0x2::object::id<Phaser>(arg1),
            account    : arg2,
            mint_count : arg3,
        };
        0x2::event::emit<IncrementEvent>(v1);
    }

    fun init(arg0: PHASER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PHASER>(arg0, arg1);
        let v1 = 0x2::display::new<Phaser>(&v0, arg1);
        0x2::display::add<Phaser>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} for {collection_type}"));
        0x2::display::update_version<Phaser>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Phaser>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser) {
        assert_owner(arg0);
        assert!(arg1.version < 1, 10002);
        arg1.version = 1;
    }

    public fun modify_phaser(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version(arg1);
        assert_owner(arg0);
        arg1.price = arg2;
        arg1.sender_per_limit = arg3;
        arg1.sender_total_limit = arg4;
        arg1.total_supply = arg5;
        arg1.start_time = arg6;
        arg1.end_time = arg7;
        let v0 = ModifyPhaserEvent{
            phaser             : 0x2::object::id<Phaser>(arg1),
            price              : arg2,
            sender_per_limit   : arg3,
            sender_total_limit : arg4,
            total_supply       : arg5,
            start_time         : arg6,
            end_time           : arg7,
        };
        0x2::event::emit<ModifyPhaserEvent>(v0);
    }

    public fun remove_phaser_whitelists(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser, arg2: vector<address>) {
        assert_version(arg1);
        assert_owner(arg0);
        let v0 = &mut arg1.whitelist_merkle_roots;
        let v1 = RemovePhaserWhitelistsEvent{
            phaser : 0x2::object::id<Phaser>(arg1),
            roots  : remove_whitelists(v0, arg2),
        };
        0x2::event::emit<RemovePhaserWhitelistsEvent>(v1);
    }

    fun remove_whitelists(arg0: &mut 0x2::table::Table<address, bool>, arg1: vector<address>) : vector<address> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(arg0, v2)) {
                0x1::vector::push_back<address>(&mut v1, v2);
                0x2::table::remove<address, bool>(arg0, v2);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun set_phaser_status(arg0: &mut 0x2::package::Publisher, arg1: &mut Phaser, arg2: u8) {
        assert_version(arg1);
        assert_owner(arg0);
        assert_phaser_status(arg2);
        arg1.status = arg2;
        let v0 = SetPhaserStatusEvent{
            phaser : 0x2::object::id<Phaser>(arg1),
            status : arg2,
        };
        0x2::event::emit<SetPhaserStatusEvent>(v0);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

