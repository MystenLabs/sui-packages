module 0xeb206a9b22cd83d3355220e3b5efce3bd95c358fc32a5ed4f5a06214f7ec0078::registry_v2 {
    struct UsernameRegistry has key {
        id: 0x2::object::UID,
        username_to_nft: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        nft_to_username: 0x2::table::Table<0x2::object::ID, 0x1::string::String>,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : UsernameRegistry {
        UsernameRegistry{
            id              : 0x2::object::new(arg0),
            username_to_nft : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            nft_to_username : 0x2::table::new<0x2::object::ID, 0x1::string::String>(arg0),
        }
    }

    public fun get_nft_by_username(arg0: &UsernameRegistry, arg1: vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.username_to_nft, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.username_to_nft, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public entry fun get_nft_by_username_bytes(arg0: &UsernameRegistry, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.username_to_nft, v0)) {
            let v2 = *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.username_to_nft, v0);
            0x2::object::id_to_bytes(&v2)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun get_username_by_nft(arg0: &UsernameRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg0.nft_to_username, arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<0x2::object::ID, 0x1::string::String>(&arg0.nft_to_username, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<UsernameRegistry>(create(arg0));
    }

    public fun is_username_available(arg0: &UsernameRegistry, arg1: vector<u8>) : bool {
        !0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.username_to_nft, 0x1::string::utf8(arg1))
    }

    public entry fun is_username_available_entry(arg0: &UsernameRegistry, arg1: vector<u8>) : bool {
        is_username_available(arg0, arg1)
    }

    fun register_username(arg0: &mut UsernameRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        assert!(0x1::string::length(&v0) > 0, 3);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.username_to_nft, v0), 1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.username_to_nft, v0, arg1);
        0x2::table::add<0x2::object::ID, 0x1::string::String>(&mut arg0.nft_to_username, arg1, v0);
    }

    public entry fun register_username_with_fee(arg0: &mut UsernameRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 200000000, 4);
        register_username(arg0, arg1, arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0xd18a60b68e3d1f1eabfce2584b61174e41940ebb9f955114f6e12fd86f69e208);
    }

    public entry fun update_profile(arg0: &mut UsernameRegistry, arg1: &mut 0xeb206a9b22cd83d3355220e3b5efce3bd95c358fc32a5ed4f5a06214f7ec0078::profile_nft::UserProfileNFT, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0xeb206a9b22cd83d3355220e3b5efce3bd95c358fc32a5ed4f5a06214f7ec0078::profile_nft::update(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun username_exists(arg0: &UsernameRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.username_to_nft, 0x1::string::utf8(arg1))
    }

    // decompiled from Move bytecode v6
}

