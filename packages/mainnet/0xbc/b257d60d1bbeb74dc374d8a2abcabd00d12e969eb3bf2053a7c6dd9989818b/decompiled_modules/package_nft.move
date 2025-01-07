module 0xbcb257d60d1bbeb74dc374d8a2abcabd00d12e969eb3bf2053a7c6dd9989818b::package_nft {
    struct PackageVerified has key {
        id: 0x2::object::UID,
        package: 0x2::object::ID,
        package_owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_name: 0x1::string::String,
        auditor: 0x1::string::String,
        creator: address,
    }

    struct PackageInfo has copy, drop, store {
        id: 0x2::object::ID,
        package: 0x2::object::ID,
        package_owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_name: 0x1::string::String,
        auditor: 0x1::string::String,
        creator: address,
    }

    struct SecurityCompany has store {
        account: address,
        name: 0x1::string::String,
        verified: bool,
    }

    struct PackageStore has store, key {
        id: 0x2::object::UID,
        packages: 0x2::table::Table<0x2::object::ID, PackageInfo>,
        security_companys: 0x2::table::Table<address, SecurityCompany>,
    }

    struct PACKAGE_NFT has drop {
        dummy_field: bool,
    }

    public entry fun approve_security_company(arg0: &mut PackageStore, arg1: address, arg2: bool) {
        0x2::table::borrow_mut<address, SecurityCompany>(&mut arg0.security_companys, arg1).verified = arg2;
    }

    fun init(arg0: PACKAGE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageStore{
            id                : 0x2::object::new(arg1),
            packages          : 0x2::table::new<0x2::object::ID, PackageInfo>(arg1),
            security_companys : 0x2::table::new<address, SecurityCompany>(arg1),
        };
        0x2::transfer::share_object<PackageStore>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"package"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"package_owner"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"auditor"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{package}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{package_owner}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{auditor}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::package::claim<PACKAGE_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<PackageVerified>(&v5, v1, v3, arg1);
        0x2::display::update_version<PackageVerified>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<PackageVerified>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_valid_security_company(arg0: &PackageStore, arg1: address) : bool {
        if (!0x2::table::contains<address, SecurityCompany>(&arg0.security_companys, arg1)) {
            return false
        };
        0x2::table::borrow<address, SecurityCompany>(&arg0.security_companys, arg1).verified
    }

    public entry fun mint(arg0: &mut PackageStore, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_security_company(arg0, 0x2::tx_context::sender(arg7)), 101);
        let v0 = 0x2::table::borrow<address, SecurityCompany>(&arg0.security_companys, 0x2::tx_context::sender(arg7));
        let v1 = PackageVerified{
            id            : 0x2::object::new(arg7),
            package       : arg1,
            package_owner : arg2,
            name          : 0x1::string::utf8(arg3),
            description   : 0x1::string::utf8(arg4),
            image_url     : 0x1::string::utf8(arg5),
            project_name  : 0x1::string::utf8(arg6),
            auditor       : v0.name,
            creator       : v0.account,
        };
        let v2 = 0x2::object::id<PackageVerified>(&v1);
        let v3 = PackageInfo{
            id            : v2,
            package       : arg1,
            package_owner : arg2,
            name          : 0x1::string::utf8(arg3),
            description   : 0x1::string::utf8(arg4),
            image_url     : 0x1::string::utf8(arg5),
            project_name  : 0x1::string::utf8(arg6),
            auditor       : v0.name,
            creator       : v0.account,
        };
        0x2::table::add<0x2::object::ID, PackageInfo>(&mut arg0.packages, v2, v3);
        0x2::transfer::transfer<PackageVerified>(v1, arg2);
    }

    public fun query(arg0: 0x2::object::ID, arg1: &PackageStore) : PackageInfo {
        assert!(0x2::table::contains<0x2::object::ID, PackageInfo>(&arg1.packages, arg0), 102);
        *0x2::table::borrow<0x2::object::ID, PackageInfo>(&arg1.packages, arg0)
    }

    public entry fun request_security_company(arg0: &mut PackageStore, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SecurityCompany{
            account  : 0x2::tx_context::sender(arg2),
            name     : 0x1::string::utf8(arg1),
            verified : false,
        };
        0x2::table::add<address, SecurityCompany>(&mut arg0.security_companys, 0x2::tx_context::sender(arg2), v0);
    }

    // decompiled from Move bytecode v6
}

