module 0xb25a2f6c2e2c51e9bf46c52d4a50e3539d2d027db18062cf3e57b4c39aa7e0a7::asset_minting {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionCreateAuthorityCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionConfig has key {
        id: 0x2::object::UID,
        status: u8,
        signingAuthorityRequired: bool,
        signingAuthorityPublicKey: vector<u8>,
        updateAuthority: address,
        collectionId: address,
    }

    struct SigningAuthorityConfig has key {
        id: 0x2::object::UID,
        publicKey: vector<u8>,
        updateAuthority: address,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct ASSET_MINTING has drop {
        dummy_field: bool,
    }

    struct NFTData has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::attributes::Attributes,
    }

    public entry fun active_collection(arg0: &mut CollectionConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.updateAuthority == 0x2::tx_context::sender(arg1), 30005);
        arg0.status = 1;
    }

    public entry fun create_collection(arg0: &CollectionCreateAuthorityCap, arg1: vector<u8>, arg2: address, arg3: bool, arg4: 0x1::option::Option<u64>, arg5: address, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<address>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::from_witness<NFTData, Witness>(v0);
        let v2 = Witness{dummy_field: false};
        let v3 = 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::create<NFTData>(v1, arg9);
        let v4 = CollectionConfig{
            id                        : 0x2::object::new(arg9),
            status                    : 1,
            signingAuthorityRequired  : arg3,
            signingAuthorityPublicKey : arg1,
            updateAuthority           : arg2,
            collectionId              : 0x2::object::id_address<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<NFTData>>(&v3),
        };
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::add_domain<NFTData, 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::display_info::DisplayInfo>(v1, &mut v3, 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::display_info::new(0x1::string::utf8(arg6), 0x1::string::utf8(arg7)));
        if (!0x1::vector::is_empty<address>(&arg8)) {
            let v5 = 0x2::vec_set::empty<address>();
            let v6 = 0x1::vector::length<address>(&arg8);
            if (v6 == 1) {
                v5 = 0x2::vec_set::singleton<address>(*0x1::vector::borrow<address>(&arg8, 0));
            } else {
                let v7 = 0;
                while (v7 < v6) {
                    0x2::vec_set::insert<address>(&mut v5, *0x1::vector::borrow<address>(&arg8, v7));
                    v7 = v7 + 1;
                };
            };
            0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::add_domain<NFTData, 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::creators::Creators>(v1, &mut v3, 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::creators::new(v5));
        };
        0x2::transfer::public_transfer<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<NFTData>>(0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::new<Witness, NFTData>(&v2, 0x2::object::id<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<NFTData>>(&v3), arg4, arg9), arg5);
        0x2::transfer::public_share_object<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<NFTData>>(v3);
        0x2::transfer::share_object<CollectionConfig>(v4);
    }

    public entry fun create_collection_create_authority_cap(arg0: &SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionCreateAuthorityCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<CollectionCreateAuthorityCap>(v0, arg1);
    }

    public entry fun deactive_collection(arg0: &mut CollectionConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.updateAuthority == 0x2::tx_context::sender(arg1), 30005);
        arg0.status = 2;
    }

    fun init(arg0: ASSET_MINTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::package::claim<ASSET_MINTING>(arg0, arg1);
        let v2 = 0x2::display::new<NFTData>(&v1, arg1);
        0x2::display::add<NFTData>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFTData>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFTData>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<NFTData>(&mut v2, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<NFTData>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<NFTData>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<NFTData>, arg1: &CollectionConfig, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: 0x1::option::Option<vector<u8>>, arg9: 0x1::option::Option<vector<u8>>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 30001);
        if (arg1.signingAuthorityRequired) {
            assert!(0x1::option::is_some<vector<u8>>(&arg8), 30002);
            assert!(0x1::option::is_some<vector<u8>>(&arg9), 30003);
            let v0 = 0x1::option::extract<vector<u8>>(&mut arg8);
            let v1 = 0x2::hash::keccak256(&v0);
            let v2 = 0x1::option::extract<vector<u8>>(&mut arg9);
            assert!(0x2::ed25519::ed25519_verify(&v2, &arg1.signingAuthorityPublicKey, &v1) == true, 30004);
        };
        let v3 = NFTData{
            id          : 0x2::object::new(arg10),
            name        : 0x1::string::utf8(arg3),
            description : 0x1::string::utf8(arg4),
            url         : 0x2::url::new_unsafe_from_bytes(arg5),
            attributes  : 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::attributes::from_vec(arg6, arg7),
        };
        let v4 = Witness{dummy_field: false};
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_event::emit_mint<NFTData>(0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::from_witness<NFTData, Witness>(v4), 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::collection_id<NFTData>(arg0), &v3);
        0x2::transfer::public_transfer<NFTData>(v3, arg2);
    }

    public entry fun update_collection_signing_required(arg0: &mut CollectionConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.updateAuthority == 0x2::tx_context::sender(arg2), 30005);
        arg0.signingAuthorityRequired = arg1;
    }

    // decompiled from Move bytecode v6
}

