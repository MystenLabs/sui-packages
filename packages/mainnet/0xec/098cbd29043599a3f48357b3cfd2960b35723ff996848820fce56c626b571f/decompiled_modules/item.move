module 0xec098cbd29043599a3f48357b3cfd2960b35723ff996848820fce56c626b571f::item {
    struct ITEM has drop {
        dummy_field: bool,
    }

    struct ItemCatalog has key {
        id: 0x2::object::UID,
        version: u64,
        types: 0x2::table::Table<0x2::object::ID, ItemType>,
    }

    struct ItemType has store {
        item_id: u64,
        item_type: 0x1::string::String,
        rank: 0x1::option::Option<u8>,
        stat_boosts: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun create_type(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<ITEM>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<ITEM>, arg2: &mut ItemCatalog, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<u64>, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::option::Option<u8>, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg2);
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_type<ITEM>(arg0, arg1, arg3, arg4, arg5, 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), arg6, arg12);
        let v1 = ItemType{
            item_id     : arg7,
            item_type   : arg8,
            rank        : arg9,
            stat_boosts : to_str_map(arg10, arg11),
        };
        0x2::table::add<0x2::object::ID, ItemType>(&mut arg2.types, v0, v1);
        v0
    }

    fun assert_version(arg0: &ItemCatalog) {
        assert!(arg0.version == 1, 13906834479286190083);
    }

    public fun has_item_type(arg0: &ItemCatalog, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, ItemType>(&arg0.types, arg1)
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<ITEM>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_and_share_registry<ITEM>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<ITEM>(&arg0, arg1);
        let v1 = ItemCatalog{
            id      : 0x2::object::new(arg1),
            version : 1,
            types   : 0x2::table::new<0x2::object::ID, ItemType>(arg1),
        };
        0x2::transfer::share_object<ItemCatalog>(v1);
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<ITEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<ITEM>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<ITEM>(&v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::BurnerCap<ITEM>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_burner<ITEM>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun item_id(arg0: &ItemType) : u64 {
        arg0.item_id
    }

    public fun item_type(arg0: &ItemType) : 0x1::string::String {
        arg0.item_type
    }

    public fun item_type_info(arg0: &ItemCatalog, arg1: 0x2::object::ID) : &ItemType {
        0x2::table::borrow<0x2::object::ID, ItemType>(&arg0.types, arg1)
    }

    public fun migrate(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<ITEM>, arg1: &mut ItemCatalog) {
        assert!(arg1.version < 1, 13906834505056124933);
        arg1.version = 1;
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<ITEM>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<ITEM>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<ITEM>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<ITEM>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::mint<ITEM>(arg0, arg2, arg4, arg5, arg6, arg7);
    }

    public fun rank(arg0: &ItemType) : 0x1::option::Option<u8> {
        arg0.rank
    }

    public fun stat_boosts(arg0: &ItemType) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.stat_boosts
    }

    fun to_str_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 13906834835768344577);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun version(arg0: &ItemCatalog) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

