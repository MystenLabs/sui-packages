module 0xe610a4c7fb915bd58ee29fd41ae0f195565f432fb1d7d1e231b29574ff3bcb92::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct BabySuiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        img_url: 0x2::url::Url,
        url: 0x2::url::Url,
        creator: address,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Global<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: 0x2::bag::Bag,
        reward_coins: 0x2::coin::Coin<T0>,
        total_reward: u64,
        reward_per_ref: u64,
        fee_per_mint: u64,
        total_mint: u64,
        max_mint: u64,
        stop: bool,
        baseuri: vector<u8>,
        start_time: u64,
        start_claim_time: u64,
        max_mint_per_user: u64,
        admin: address,
    }

    struct UserData has store {
        total_ref: u64,
        total_claim: u64,
        total_mint: u64,
        ref_from: address,
    }

    public fun url(arg0: &BabySuiNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: BabySuiNFT) {
        let BabySuiNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            img_url     : _,
            url         : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun claim_ref<T0>(arg0: &mut Global<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.start_claim_time < 0x2::clock::timestamp_ms(arg1), 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains_with_type<address, UserData>(&arg0.user, v0), 6);
        let v1 = arg0.reward_per_ref;
        let v2 = get_mut_user_data<T0>(arg0, v0);
        assert!(v2.total_ref > 0, 6);
        assert!(v2.total_claim < v2.total_ref, 7);
        v2.total_claim = v2.total_ref;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.reward_coins, (v2.total_ref - v2.total_claim) * v1, arg2), v0);
    }

    public fun convert_to_string(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = arg0;
        loop {
            let v2 = v1 % 10;
            v1 = v1 / 10;
            if (v2 == 0) {
                0x1::vector::append<u8>(&mut v0, b"0");
            } else if (v2 == 1) {
                0x1::vector::append<u8>(&mut v0, b"1");
            } else if (v2 == 2) {
                0x1::vector::append<u8>(&mut v0, b"2");
            } else if (v2 == 3) {
                0x1::vector::append<u8>(&mut v0, b"3");
            } else if (v2 == 4) {
                0x1::vector::append<u8>(&mut v0, b"4");
            } else if (v2 == 5) {
                0x1::vector::append<u8>(&mut v0, b"5");
            } else if (v2 == 6) {
                0x1::vector::append<u8>(&mut v0, b"6");
            } else if (v2 == 7) {
                0x1::vector::append<u8>(&mut v0, b"7");
            } else if (v2 == 8) {
                0x1::vector::append<u8>(&mut v0, b"8");
            } else if (v2 == 9) {
                0x1::vector::append<u8>(&mut v0, b"9");
            };
            if (v1 == 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun description(arg0: &BabySuiNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_mut_user_data<T0>(arg0: &mut Global<T0>, arg1: address) : &mut UserData {
        assert!(0x2::bag::contains_with_type<address, UserData>(&arg0.user, arg1), 4);
        0x2::bag::borrow_mut<address, UserData>(&mut arg0.user, arg1)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description} - Minted by babysui.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://babysui.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BaBySui Fan"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BabySuiNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BabySuiNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<BabySuiNFT>>(v5, v6);
    }

    public entry fun init_rewards<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        if (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::pay::join_vec<T0>(&mut v0, arg0);
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        };
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        let v1 = Global<T0>{
            id                : 0x2::object::new(arg9),
            user              : 0x2::bag::new(arg9),
            reward_coins      : 0x2::coin::split<T0>(&mut v0, arg1, arg9),
            total_reward      : arg1,
            reward_per_ref    : arg2,
            fee_per_mint      : arg3,
            total_mint        : 0,
            max_mint          : arg4,
            stop              : false,
            baseuri           : arg6,
            start_time        : arg7,
            start_claim_time  : arg8,
            max_mint_per_user : arg5,
            admin             : 0x2::tx_context::sender(arg9),
        };
        0x2::transfer::share_object<Global<T0>>(v1);
    }

    public entry fun mint<T0>(arg0: &mut Global<T0>, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_mint <= arg0.max_mint, 5);
        assert!(arg0.start_time < 0x2::clock::timestamp_ms(arg3), 9);
        assert!(arg0.stop == false, 10);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        if (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg1)) {
            0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg1);
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg0.fee_per_mint, arg4), @0x942e04899dc9ade6504873058c6a8f491ce7e2b76677008efd263d635dae452);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        arg0.total_mint = arg0.total_mint + 1;
        let v1 = convert_to_string(arg0.total_mint);
        let v2 = 0x1::string::utf8(arg0.baseuri);
        0x1::string::append_utf8(&mut v2, v1);
        0x1::string::append_utf8(&mut v2, b".jpg");
        let v3 = 0x1::string::utf8(b"BabySui");
        0x1::string::append_utf8(&mut v3, b" #");
        0x1::string::append_utf8(&mut v3, v1);
        let v4 = BabySuiNFT{
            id          : 0x2::object::new(arg4),
            name        : v3,
            description : 0x1::string::utf8(b"BabySui"),
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(v2)),
            img_url     : 0x2::url::new_unsafe(0x1::string::to_ascii(v2)),
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(v2)),
            creator     : 0x2::tx_context::sender(arg4),
        };
        let v5 = 0x2::tx_context::sender(arg4);
        let v6 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v4.id),
            creator   : v5,
            name      : v4.name,
        };
        0x2::event::emit<MintNFTEvent>(v6);
        0x2::transfer::public_transfer<BabySuiNFT>(v4, v5);
        let v7 = arg0.max_mint_per_user;
        if (!0x2::bag::contains_with_type<address, UserData>(&arg0.user, v5)) {
            let v8 = UserData{
                total_ref   : 0,
                total_claim : 0,
                total_mint  : 1,
                ref_from    : arg2,
            };
            0x2::bag::add<address, UserData>(&mut arg0.user, v5, v8);
        } else {
            let v9 = get_mut_user_data<T0>(arg0, v5);
            assert!(v9.total_mint < v7, 3);
            v9.total_mint = v9.total_mint + 1;
        };
        if (!0x2::bag::contains_with_type<address, UserData>(&arg0.user, arg2)) {
            let v10 = UserData{
                total_ref   : 1,
                total_claim : 0,
                total_mint  : 0,
                ref_from    : arg2,
            };
            0x2::bag::add<address, UserData>(&mut arg0.user, arg2, v10);
        } else {
            let v11 = get_mut_user_data<T0>(arg0, arg2);
            v11.total_ref = v11.total_ref + 1;
        };
    }

    public fun name(arg0: &BabySuiNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun set_var<T0>(arg0: &mut Global<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg10), 11);
        arg0.total_reward = arg1;
        arg0.reward_per_ref = arg2;
        arg0.fee_per_mint = arg3;
        arg0.max_mint = arg4;
        arg0.max_mint_per_user = arg5;
        arg0.baseuri = arg6;
        arg0.start_time = arg7;
        arg0.start_claim_time = arg8;
        arg0.stop = arg9;
    }

    public entry fun update_description(arg0: &mut BabySuiNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

