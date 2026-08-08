module 0x39ef1fea5f3bc6877fd3783d756583ba482b1e29b366424a5e7ca46f456d214b::golden_key {
    struct GOLDEN_KEY has drop {
        dummy_field: bool,
    }

    public fun create_type(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<GOLDEN_KEY>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<GOLDEN_KEY>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_type<GOLDEN_KEY>(arg0, arg1, 0x1::string::utf8(b"GangstaBet Golden Key"), arg2, arg3, 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), 0x1::option::some<u64>(2000), arg4)
    }

    fun init(arg0: GOLDEN_KEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<GOLDEN_KEY>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_and_share_registry<GOLDEN_KEY>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<GOLDEN_KEY>(&arg0, arg1);
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<GOLDEN_KEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<GOLDEN_KEY>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<GOLDEN_KEY>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<GOLDEN_KEY>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<GOLDEN_KEY>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<GOLDEN_KEY>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<GOLDEN_KEY>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::mint<GOLDEN_KEY>(arg0, arg2, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

