module 0x39ef1fea5f3bc6877fd3783d756583ba482b1e29b366424a5e7ca46f456d214b::bribe {
    struct BRIBE has drop {
        dummy_field: bool,
    }

    struct BribeSupply has key {
        id: 0x2::object::UID,
        version: u64,
        total_minted: u64,
    }

    fun assert_version(arg0: &BribeSupply) {
        assert!(arg0.version == 1, 13906834419156844550);
    }

    public fun global_cap() : u64 {
        600
    }

    fun init(arg0: BRIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<BRIBE>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_and_share_registry<BRIBE>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<BRIBE>(&arg0, arg1);
        let v1 = BribeSupply{
            id           : 0x2::object::new(arg1),
            version      : 1,
            total_minted : 0,
        };
        0x2::transfer::share_object<BribeSupply>(v1);
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<BRIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<BRIBE>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<BRIBE>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun migrate(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<BRIBE>, arg1: &mut BribeSupply) {
        assert!(arg1.version < 1, 13906834444926779400);
        arg1.version = 1;
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<BRIBE>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<BRIBE>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<BRIBE>, arg3: &mut BribeSupply, arg4: vector<u8>, arg5: 0x2::object::ID, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<BRIBE>(arg0, arg1, arg4);
        assert!(arg3.total_minted + arg6 <= 600, 13906834724099391492);
        arg3.total_minted = arg3.total_minted + arg6;
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::mint<BRIBE>(arg0, arg2, arg5, arg6, arg7, arg8);
    }

    public fun seed_types(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<BRIBE>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<BRIBE>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = zone_names();
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&v0), 13906834565185470466);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&v0), 13906834569480437762);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_type<BRIBE>(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&v0, v2), *0x1::vector::borrow<0x1::string::String>(&arg2, v2), *0x1::vector::borrow<0x1::string::String>(&arg3, v2), 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), 0x1::option::none<u64>(), arg4));
            v2 = v2 + 1;
        };
        v1
    }

    public fun total_minted(arg0: &BribeSupply) : u64 {
        arg0.total_minted
    }

    public fun version(arg0: &BribeSupply) : u64 {
        arg0.version
    }

    fun zone_names() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Recreational"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Airport"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Industrial"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Governmental"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Education"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Health"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Commercial"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Residential"));
        v0
    }

    // decompiled from Move bytecode v7
}

