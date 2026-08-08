module 0x39ef1fea5f3bc6877fd3783d756583ba482b1e29b366424a5e7ca46f456d214b::land_cert {
    struct LAND_CERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAND_CERT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<LAND_CERT>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_and_share_registry<LAND_CERT>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<LAND_CERT>(&arg0, arg1);
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<LAND_CERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<LAND_CERT>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<LAND_CERT>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<LAND_CERT>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<LAND_CERT>, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::mint<LAND_CERT>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<LAND_CERT>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<LAND_CERT>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<LAND_CERT>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<LAND_CERT>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::mint<LAND_CERT>(arg0, arg2, arg4, arg5, arg6, arg7);
    }

    public fun seed_types(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<LAND_CERT>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Registry<LAND_CERT>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = zone_names();
        let v1 = vector[371, 178, 112, 186, 63, 75, 1170, 1445];
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&v0), 13906834432041484290);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&v0), 13906834436336451586);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::create_type<LAND_CERT>(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&v0, v3), *0x1::vector::borrow<0x1::string::String>(&arg2, v3), *0x1::vector::borrow<0x1::string::String>(&arg3, v3), 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), 0x1::option::some<u64>(*0x1::vector::borrow<u64>(&v1, v3)), arg4));
            v3 = v3 + 1;
        };
        v2
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

