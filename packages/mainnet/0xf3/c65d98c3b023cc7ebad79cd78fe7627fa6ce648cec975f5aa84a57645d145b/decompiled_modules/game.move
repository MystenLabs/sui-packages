module 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::game {
    struct DegenStore has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        minting_price: u64,
        inner_hash: vector<u8>,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        nonces: 0x2::vec_set::VecSet<u64>,
    }

    struct EquippedDegenMinted has copy, drop {
        token_id: u64,
        degen_id: 0x2::object::ID,
        items: vector<ItemMinted>,
    }

    struct ItemLooted has copy, drop {
        id: 0x2::object::ID,
        token_id: u64,
        receiver: address,
    }

    struct ItemMinted has copy, drop {
        id: 0x2::object::ID,
        token_id: u64,
    }

    struct WellOfSouls has copy, drop {
        token_id: u64,
        degen_id: 0x2::object::ID,
        items: vector<ItemMinted>,
        burn_ids: vector<0x2::object::ID>,
        unequipped_item_ids: vector<0x2::object::ID>,
    }

    public fun leave_arena<T0>(arg0: &mut DegenStore, arg1: 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>) {
        0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::leave_arena<T0>(&mut arg0.id, arg1);
    }

    public fun mint<T0>(arg0: &mut DegenStore, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0> {
        assert!(0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::is_authorized<T0>(&mut arg0.id), 2);
        assert!(arg0.is_active == true, 3);
        verify(arg2, 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::utils::address_to_bytes(arg0.admin), arg1);
        handle_payment(arg0, 1, arg5, arg6);
        let (v0, v1) = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::deserialize_degen_params(arg2);
        let v2 = v0;
        let v3 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::mint<T0>(&mut arg0.id, arg3, v1, arg1, arg4, arg6);
        let v4 = 0;
        let v5 = 0x1::vector::empty<ItemMinted>();
        while (v4 < 0x1::vector::length<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::ItemParams>(&v2)) {
            let v6 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::mint(0x1::vector::borrow<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::ItemParams>(&v2, v4), arg6);
            0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::add_item_to_degen<T0>(&mut v3, v6);
            let v7 = ItemMinted{
                id       : 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&v6),
                token_id : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::get_token_id(&v6),
            };
            0x1::vector::push_back<ItemMinted>(&mut v5, v7);
            v4 = v4 + 1;
        };
        let v8 = EquippedDegenMinted{
            token_id : v1,
            degen_id : 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(&v3),
            items    : v5,
        };
        0x2::event::emit<EquippedDegenMinted>(v8);
        v3
    }

    public fun airdrop_degen<T0>(arg0: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::AdminCap, arg1: &mut DegenStore, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::is_authorized<T0>(&mut arg1.id), 2);
        assert!(arg1.is_active == true, 3);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg3), 6);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(mint_one<T0>(arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v1), *0x1::vector::borrow<vector<u8>>(&arg3, v1), 0x1::string::utf8(b""), arg5, arg6), arg4);
            v1 = v1 + 1;
        };
    }

    public fun authorize<T0>(arg0: &mut DegenStore, arg1: 0x1::string::String, arg2: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::authorize_app<T0>(&mut arg0.id, arg2, arg3);
    }

    public fun authorize_item<T0>(arg0: &mut DegenStore, arg1: 0x1::string::String, arg2: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::AdminCap) {
        0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::authorize_app<T0>(&mut arg0.id, arg1, arg2);
    }

    public fun blacksmith(arg0: &mut DegenStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item {
        verify(arg2, 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::utils::address_to_bytes(arg0.admin), arg1);
        0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::trade(arg1, arg2, arg3, arg4, arg5)
    }

    public fun contains_object(arg0: &DegenStore, arg1: &u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.nonces, arg1)
    }

    public fun deauthorize<T0>(arg0: &mut DegenStore, arg1: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::AdminCap) {
        0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::revoke_auth<T0>(&mut arg0.id, arg1);
    }

    public fun deauthorize_item<T0>(arg0: &mut DegenStore, arg1: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::AdminCap) {
        0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::revoke_auth<T0>(&mut arg0.id, arg1);
    }

    public fun enter_arena<T0>(arg0: &mut DegenStore, arg1: 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>) {
        0x2::transfer::public_transfer<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(arg1, arg0.admin);
    }

    fun handle_payment(arg0: &mut DegenStore, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minting_price * arg1;
        assert!(v0 <= 0x2::coin::value<0x2::sui::SUI>(arg2), 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = DegenStore{
            id            : v0,
            is_active     : true,
            minting_price : 20000000000,
            inner_hash    : 0x2::hash::blake2b256(&v1),
            profits       : 0x2::balance::zero<0x2::sui::SUI>(),
            admin         : 0x2::tx_context::sender(arg0),
            nonces        : 0x2::vec_set::empty<u64>(),
        };
        0x2::transfer::share_object<DegenStore>(v2);
    }

    public entry fun insert_nonce(arg0: &mut DegenStore, arg1: u64) {
        assert!(!contains_object(arg0, &arg1), 4);
        0x2::vec_set::insert<u64>(&mut arg0.nonces, arg1);
        0x1::debug::print<0x2::vec_set::VecSet<u64>>(&arg0.nonces);
    }

    public fun loot_item(arg0: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::AdminCap, arg1: &mut DegenStore, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item {
        assert!(arg1.is_active == true, 3);
        let v0 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::deserialize_single_item_params(arg2);
        let v1 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::mint(&v0, arg4);
        let v2 = ItemLooted{
            id       : 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&v1),
            token_id : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::get_token_id(&v1),
            receiver : arg3,
        };
        0x2::event::emit<ItemLooted>(v2);
        v1
    }

    public fun mint_many<T0>(arg0: &mut DegenStore, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::is_authorized<T0>(&mut arg0.id), 2);
        assert!(arg0.is_active == true, 3);
        handle_payment(arg0, arg3, arg5, arg6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = mint_one<T0>(arg0, *0x1::vector::borrow<vector<u8>>(&arg1, v0), *0x1::vector::borrow<vector<u8>>(&arg2, v0), 0x1::string::utf8(b""), arg4, arg6);
            0x2::transfer::public_transfer<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(v1, 0x2::tx_context::sender(arg6));
            v0 = v0 + 1;
        };
    }

    fun mint_one<T0>(arg0: &mut DegenStore, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0> {
        verify(arg2, 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::utils::address_to_bytes(arg0.admin), arg1);
        let (v0, v1) = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::deserialize_degen_params(arg2);
        let v2 = v0;
        let v3 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::mint<T0>(&mut arg0.id, arg3, v1, arg1, arg4, arg5);
        let v4 = 0;
        let v5 = 0x1::vector::empty<ItemMinted>();
        while (v4 < 0x1::vector::length<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::ItemParams>(&v2)) {
            let v6 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::mint(0x1::vector::borrow<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::ItemParams>(&v2, v4), arg5);
            0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::add_item_to_degen<T0>(&mut v3, v6);
            let v7 = ItemMinted{
                id       : 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&v6),
                token_id : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::get_token_id(&v6),
            };
            0x1::vector::push_back<ItemMinted>(&mut v5, v7);
            v4 = v4 + 1;
        };
        let v8 = EquippedDegenMinted{
            token_id : v1,
            degen_id : 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(&v3),
            items    : v5,
        };
        0x2::event::emit<EquippedDegenMinted>(v8);
        v3
    }

    public fun resurrect<T0>(arg0: &mut DegenStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>, arg4: vector<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0> {
        assert!(0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::is_authorized<T0>(&mut arg0.id), 2);
        assert!(arg0.is_active == true, 3);
        verify(arg2, 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::utils::address_to_bytes(arg0.admin), arg1);
        let (_, v1) = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::deserialize_degen_params(arg2);
        let v2 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::mint<T0>(&mut arg0.id, 0x1::string::utf8(b""), v1, arg1, arg5, arg6);
        let v3 = 0;
        let v4 = 0x1::vector::empty<ItemMinted>();
        while (v3 < 0x1::vector::length<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&arg4)) {
            let v5 = 0x1::vector::pop_back<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&mut arg4);
            0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::add_item_to_degen<T0>(&mut v2, v5);
            let v6 = ItemMinted{
                id       : 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&v5),
                token_id : 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::get_token_id(&v5),
            };
            0x1::vector::push_back<ItemMinted>(&mut v4, v6);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(arg4);
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = 0x1::vector::length<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(&arg3);
        let v9 = 0;
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"head"));
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"body"));
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"weapon"));
        assert!(v8 == 4, 5);
        while (v9 < v8) {
            let v12 = 0x1::vector::pop_back<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(&mut arg3);
            let v13 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::unequip_all<T0>(&mut v12, v10);
            let v14 = 0;
            while (v14 < 0x1::vector::length<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&v13)) {
                let v15 = 0x1::vector::pop_back<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&mut v13);
                0x1::debug::print<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&v15);
                0x1::vector::push_back<0x2::object::ID>(&mut v11, 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(&v15));
                0x2::transfer::public_transfer<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(v15, 0x2::tx_context::sender(arg6));
                v14 = v14 + 1;
            };
            0x1::vector::destroy_empty<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::item::Item>(v13);
            let v16 = 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::burn<T0>(&mut arg0.id, v12);
            0x1::vector::push_back<0x2::object::ID>(&mut v7, 0x2::object::uid_to_inner(&v16));
            0x2::object::delete(v16);
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(arg3);
        let v17 = WellOfSouls{
            token_id            : v1,
            degen_id            : 0x2::object::id<0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::Degen<T0>>(&v2),
            items               : v4,
            burn_ids            : v7,
            unequipped_item_ids : v11,
        };
        0x2::event::emit<WellOfSouls>(v17);
        v2
    }

    public fun set_admin(arg0: &mut DegenStore, arg1: address, arg2: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::AdminCap) {
        arg0.admin = arg1;
    }

    public fun set_minting_price(arg0: &mut DegenStore, arg1: u64, arg2: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::AdminCap) {
        arg0.minting_price = arg1;
    }

    public fun set_sale_active(arg0: &mut DegenStore, arg1: bool, arg2: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::AdminCap) {
        arg0.is_active = arg1;
    }

    public fun take_profits(arg0: &0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::degen::AdminCap, arg1: &mut DegenStore, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        assert!(v0 > 0, 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2)
    }

    public fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &arg0) == true, 0);
    }

    // decompiled from Move bytecode v6
}

