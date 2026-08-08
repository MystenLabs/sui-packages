module 0xec098cbd29043599a3f48357b3cfd2960b35723ff996848820fce56c626b571f::lootbox {
    struct LOOTBOX has drop {
        dummy_field: bool,
    }

    public fun create_type(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<LOOTBOX>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<LOOTBOX>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_type<LOOTBOX>(arg0, arg1, arg2, arg3, arg4, to_str_map(arg5, arg6), 0x1::option::none<u64>(), arg7)
    }

    fun init(arg0: LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<LOOTBOX>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_and_share_registry<LOOTBOX>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<LOOTBOX>(&arg0, arg1);
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<LOOTBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<LOOTBOX>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<LOOTBOX>(&v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::BurnerCap<LOOTBOX>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_burner<LOOTBOX>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<LOOTBOX>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<LOOTBOX>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<LOOTBOX>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<LOOTBOX>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::mint<LOOTBOX>(arg0, arg2, arg4, arg5, arg6, arg7);
    }

    fun to_str_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 13906834492170960897);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

