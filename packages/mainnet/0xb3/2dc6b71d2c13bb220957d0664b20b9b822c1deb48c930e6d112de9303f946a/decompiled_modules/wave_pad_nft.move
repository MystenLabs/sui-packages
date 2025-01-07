module 0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_pad_nft {
    struct Event<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        operator_pk: vector<u8>,
        version: u8,
        is_paused: bool,
        balance: 0x2::balance::Balance<T0>,
        rounds: vector<Round>,
    }

    struct Round has store {
        price: u64,
        start_time: u64,
        end_time: u64,
        max_buy_per_user: u64,
        total_sell: u64,
        sold: u64,
    }

    struct EventCreated has copy, drop {
        event_id: 0x2::object::ID,
        payment_type: 0x1::string::String,
        nft_type: 0x1::string::String,
        is_paused: bool,
    }

    struct EventUpdated has copy, drop {
        event_id: 0x2::object::ID,
        is_paused: bool,
    }

    struct RoundUpdated has copy, drop {
        event_id: 0x2::object::ID,
        round_id: u64,
        start_time: u64,
        end_time: u64,
        price: u64,
        max_buy_per_user: u64,
        total_sell: u64,
    }

    struct NFTBought has copy, drop, store {
        event_id: 0x2::object::ID,
        round_id: u64,
        receiver: address,
        price: u64,
        amount: u64,
        payment_type: 0x1::string::String,
        nft_type: 0x1::string::String,
        nft_ids: vector<0x2::object::ID>,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun admin_withdraw<T0, T1>(arg0: &OwnerCap, arg1: &mut Event<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun authorize_nft<T0, T1>(arg0: &0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::NftOwnerCap, arg1: &mut Event<T0, T1>) {
        0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    entry fun buy_nft<T0, T1>(arg0: &mut Event<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u16, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 7);
        assert!(arg0.is_paused == false, 10);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::object::id<Event<T0, T1>>(arg0);
        validate_signature(arg0.operator_pk, v1, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        assert!(arg1 < 0x1::vector::length<Round>(&arg0.rounds), 1);
        let v2 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg10);
        assert!(v2.start_time == 0 || v3 >= v2.start_time, 8);
        assert!(v2.end_time == 0 || v3 <= v2.end_time, 9);
        assert!(v2.total_sell == 0 || v2.sold + arg3 <= v2.total_sell, 11);
        let v4 = 0x2::bcs::to_bytes<address>(&v0);
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg1));
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v4)) {
            assert!(v2.max_buy_per_user == 0 || arg3 <= v2.max_buy_per_user, 3);
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, v4, arg3);
        } else {
            let v6 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v4);
            assert!(v2.max_buy_per_user == 0 || *v6 + arg3 <= v2.max_buy_per_user, 3);
            *v6 = *v6 + arg3;
        };
        v2.sold = v2.sold + arg3;
        let v7 = v2.price * arg3;
        assert!(0x2::coin::value<T0>(&arg2) >= v7, 2);
        0x2::pay::keep<T0>(arg2, arg11);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v7, arg11)));
        let v8 = 0x1::vector::empty<0x2::object::ID>();
        let v9 = 0;
        while (v9 < arg3) {
            let v10 = &mut arg0.id;
            0x1::vector::push_back<0x2::object::ID>(&mut v8, mint_nft(v10, v0, arg4, arg5, arg6, arg7, arg11));
            v9 = v9 + 1;
        };
        let v11 = NFTBought{
            event_id     : v1,
            round_id     : arg1,
            receiver     : v0,
            price        : v2.price,
            amount       : arg3,
            payment_type : type_to_string<T0>(),
            nft_type     : type_to_string<T1>(),
            nft_ids      : v8,
        };
        0x2::event::emit<NFTBought>(v11);
    }

    public entry fun create_event<T0, T1>(arg0: &OwnerCap, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v2 = Event<T0, T1>{
            id          : v0,
            operator_pk : 0x2::bcs::to_bytes<address>(&v1),
            version     : 1,
            is_paused   : arg1,
            balance     : 0x2::balance::zero<T0>(),
            rounds      : 0x1::vector::empty<Round>(),
        };
        0x2::transfer::share_object<Event<T0, T1>>(v2);
        let v3 = EventCreated{
            event_id     : 0x2::object::uid_to_inner(&v0),
            payment_type : type_to_string<T0>(),
            nft_type     : type_to_string<T1>(),
            is_paused    : arg1,
        };
        0x2::event::emit<EventCreated>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate<T0, T1>(arg0: &OwnerCap, arg1: &mut Event<T0, T1>) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    fun mint_nft(arg0: &mut 0x2::object::UID, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::mint(arg0, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::NFT>(v0, arg1);
        0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::get_id(&v0)
    }

    entry fun pause_event<T0, T1>(arg0: &OwnerCap, arg1: &mut Event<T0, T1>, arg2: bool) {
        arg1.is_paused = arg2;
        let v0 = EventUpdated{
            event_id  : 0x2::object::id<Event<T0, T1>>(arg1),
            is_paused : arg2,
        };
        0x2::event::emit<EventUpdated>(v0);
    }

    fun type_to_string<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    entry fun update_operator<T0, T1>(arg0: &OwnerCap, arg1: &mut Event<T0, T1>, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    public entry fun upsert_round<T0, T1>(arg0: &OwnerCap, arg1: &mut Event<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = 0x1::vector::length<Round>(&arg1.rounds);
        let v1 = arg2;
        if (arg2 < v0) {
            let v2 = 0x1::vector::borrow_mut<Round>(&mut arg1.rounds, arg2);
            v2.start_time = arg3;
            v2.end_time = arg4;
            v2.price = arg5;
            v2.max_buy_per_user = arg6;
            v2.total_sell = arg7;
        } else {
            v1 = v0;
            let v3 = Round{
                price            : arg5,
                start_time       : arg3,
                end_time         : arg4,
                max_buy_per_user : arg6,
                total_sell       : arg7,
                sold             : 0,
            };
            0x1::vector::push_back<Round>(&mut arg1.rounds, v3);
        };
        let v4 = RoundUpdated{
            event_id         : 0x2::object::id<Event<T0, T1>>(arg1),
            round_id         : v1,
            start_time       : arg3,
            end_time         : arg4,
            price            : arg5,
            max_buy_per_user : arg6,
            total_sell       : arg7,
        };
        0x2::event::emit<RoundUpdated>(v4);
    }

    fun validate_signature(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u16, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_PAD_BUY_NFT:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg3));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg5));
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg6));
        let v7 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v7));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg7));
        let v8 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v8));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u16>(&arg8));
        let v9 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v9));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg9));
        assert!(0x2::ed25519::ed25519_verify(&arg10, &arg0, &v1) == true, 4);
        assert!(0x2::clock::timestamp_ms(arg11) < arg9, 5);
    }

    // decompiled from Move bytecode v6
}

