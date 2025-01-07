module 0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::gap {
    struct GAPNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        user_details: 0x2::vec_map::VecMap<0x2::object::ID, Attributes>,
        user_token_id: 0x2::vec_map::VecMap<address, vector<0x2::object::ID>>,
    }

    struct Attributes has copy, drop, store {
        ieo: bool,
    }

    struct Allowance has copy, drop, store {
        value: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GAP has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &GAPNFT) : 0x2::object::ID {
        0x2::object::id<GAPNFT>(arg0)
    }

    public fun url(arg0: &GAPNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun update_attribute(arg0: &AdminCap, arg1: &mut NFTInfo, arg2: 0x2::object::ID, arg3: bool) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Attributes>(&arg1.user_details, &arg2), 8);
        let v0 = Attributes{ieo: arg3};
        0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft::update_attribute<0x2::object::ID, Attributes>(&mut arg1.user_details, arg2, v0);
    }

    public fun attributes(arg0: &GAPNFT, arg1: &NFTInfo) : Attributes {
        let v0 = 0x2::object::id<GAPNFT>(arg0);
        *0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.user_details, &v0)
    }

    public entry fun authorize_user(arg0: &AdminCap, arg1: &mut NFTInfo, arg2: address, arg3: u64) {
        assert!(arg3 > 0, 7);
        let v0 = 0x2::address::to_bytes(arg2);
        if (0x2::dynamic_field::exists_with_type<vector<u8>, Allowance>(&arg1.id, v0)) {
            0x2::dynamic_field::borrow_mut<vector<u8>, Allowance>(&mut arg1.id, v0).value = arg3;
        } else {
            let v1 = Allowance{value: arg3};
            0x2::dynamic_field::add<vector<u8>, Allowance>(&mut arg1.id, v0, v1);
        };
    }

    public entry fun burn(arg0: GAPNFT, arg1: &mut NFTInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<GAPNFT>(&arg0);
        assert!(0x2::vec_map::contains<0x2::object::ID, Attributes>(&arg1.user_details, &v0), 8);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, Attributes>(&mut arg1.user_details, &v0);
        let GAPNFT {
            id   : v3,
            name : _,
            url  : _,
        } = arg0;
        0x2::object::delete(v3);
        0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft::emit_burn_nft<GAPNFT>(v0);
    }

    public fun count(arg0: &NFTInfo, arg1: address) : vector<0x2::object::ID> {
        *0x2::vec_map::get<address, vector<0x2::object::ID>>(&arg0.user_token_id, &arg1)
    }

    public entry fun deauthorize_user(arg0: &AdminCap, arg1: &mut NFTInfo, arg2: address) {
        let v0 = 0x2::address::to_bytes(arg2);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, Allowance>(&arg1.id, v0), 4);
        0x2::dynamic_field::remove<vector<u8>, Allowance>(&mut arg1.id, v0);
    }

    public fun ieo(arg0: &GAPNFT, arg1: &NFTInfo) : bool {
        let v0 = 0x2::object::id<GAPNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.user_details, &v0).ieo
    }

    fun init(arg0: GAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi NFT"));
        let v4 = 0x2::package::claim<GAP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GAPNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GAPNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GAPNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFTInfo{
            id            : 0x2::object::new(arg1),
            name          : 0x1::string::utf8(b"Artfi"),
            user_details  : 0x2::vec_map::empty<0x2::object::ID, Attributes>(),
            user_token_id : 0x2::vec_map::empty<address, vector<0x2::object::ID>>(),
        };
        0x2::transfer::share_object<NFTInfo>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    fun mint_func(arg0: &mut NFTInfo, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 5);
        let v0 = GAPNFT{
            id   : 0x2::object::new(arg3),
            name : arg0.name,
            url  : 0x2::url::new_unsafe_from_bytes(arg1),
        };
        let v1 = 0x2::object::id<GAPNFT>(&v0);
        let v2 = Attributes{ieo: false};
        0x2::vec_map::insert<0x2::object::ID, Attributes>(&mut arg0.user_details, v1, v2);
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg0.user_token_id, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg0.user_token_id, &arg2), v1);
        } else {
            let v3 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v3, v1);
            0x2::vec_map::insert<address, vector<0x2::object::ID>>(&mut arg0.user_token_id, arg2, v3);
        };
        0x2::transfer::public_transfer<GAPNFT>(v0, arg2);
        v1
    }

    public fun mint_nft_batch(arg0: &AdminCap, arg1: &mut NFTInfo, arg2: &vector<vector<u8>>, arg3: &vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(arg2);
        assert!(v0 == 0x1::vector::length<address>(arg3), 2);
        assert!(v0 > 0, 7);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = mint_func(arg1, *0x1::vector::borrow<vector<u8>>(arg2, v2), *0x1::vector::borrow<address>(arg3, v2), arg4);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v3);
            v2 = v2 + 1;
        };
        0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft::emit_batch_mint_nft(v1, v0, 0x2::tx_context::sender(arg4), arg1.name);
    }

    public fun name(arg0: &GAPNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft::emit_transfer_object<AdminCap>(0x2::object::id<AdminCap>(&arg0), arg1);
    }

    public entry fun transfer_nft(arg0: GAPNFT, arg1: &mut NFTInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<GAPNFT>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg1.user_token_id, &v1)) {
            let v2 = 0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg1.user_token_id, &v1);
            let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(v2, &v0);
            if (v3) {
                0x1::vector::remove<0x2::object::ID>(v2, v4);
            };
        };
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg1.user_token_id, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg1.user_token_id, &arg2), v0);
        } else {
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v5, v0);
            0x2::vec_map::insert<address, vector<0x2::object::ID>>(&mut arg1.user_token_id, arg2, v5);
        };
        0x2::transfer::public_transfer<GAPNFT>(arg0, arg2);
        0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft::emit_transfer_object<GAPNFT>(v0, arg2);
    }

    public fun update_metadata(arg0: &AdminCap, arg1: &mut 0x2::display::Display<GAPNFT>, arg2: &mut NFTInfo, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x2::display::edit<GAPNFT>(arg1, 0x1::string::utf8(b"name"), arg4);
        0x2::display::edit<GAPNFT>(arg1, 0x1::string::utf8(b"description"), arg3);
        arg2.name = arg4;
        0x2::display::update_version<GAPNFT>(arg1);
        0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft::emit_metadat_update(arg4, arg3);
    }

    public entry fun user_mint_nft_batch(arg0: &mut NFTInfo, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::address::to_bytes(v0);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, Allowance>(&arg0.id, v1), 4);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, Allowance>(&arg0.id, v1).value;
        let v3 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v3 > 0, 7);
        assert!(v2 >= v3, 6);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = 0;
        while (v5 < v3) {
            let v6 = mint_func(arg0, *0x1::vector::borrow<vector<u8>>(&arg1, v5), v0, arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, v6);
            v5 = v5 + 1;
        };
        let v7 = v2 - v3;
        if (v7 > 0) {
            0x2::dynamic_field::remove<vector<u8>, Allowance>(&mut arg0.id, v1);
            let v8 = Allowance{value: v7};
            0x2::dynamic_field::add<vector<u8>, Allowance>(&mut arg0.id, v1, v8);
        } else {
            0x2::dynamic_field::remove<vector<u8>, Allowance>(&mut arg0.id, v1);
        };
        0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft::emit_batch_mint_nft(v4, v3, 0x2::tx_context::sender(arg2), arg0.name);
    }

    // decompiled from Move bytecode v6
}

