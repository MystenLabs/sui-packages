module 0x193a33b36a30444128353f8cefe2fab8fefac3f918f4c267c763f6adb44ead35::avatar {
    struct Metadata has store, key {
        id: 0x2::object::UID,
    }

    struct AvatarItem has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        owner: address,
        start_time: u64,
    }

    struct LockNFTEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        owner: address,
        start_time: u64,
    }

    struct WithdrawNFTEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        owner: address,
        withdraw_time: u64,
    }

    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Metadata{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Metadata>(v0);
    }

    public entry fun set_nft_for_avatar<T0: store + key>(arg0: &mut Metadata, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = get_token_name<T0>();
        let v4 = AvatarItem{
            id         : 0x2::object::new(arg3),
            nft_id     : v1,
            owner      : v0,
            start_time : v2,
        };
        if (0x2::dynamic_object_field::exists_with_type<address, AvatarItem>(&arg0.id, v0)) {
            let AvatarItem {
                id         : v5,
                nft_id     : v6,
                owner      : v7,
                start_time : _,
            } = 0x2::dynamic_object_field::remove<address, AvatarItem>(&mut arg0.id, v0);
            let v9 = v5;
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(&mut v9, true), v0);
            0x2::object::delete(v9);
            let v10 = WithdrawNFTEvent{
                nft_id        : v6,
                nft_type      : v3,
                owner         : v7,
                withdraw_time : v2,
            };
            0x2::event::emit<WithdrawNFTEvent>(v10);
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v4.id, true, arg1);
        0x2::dynamic_object_field::add<address, AvatarItem>(&mut arg0.id, v0, v4);
        let v11 = LockNFTEvent{
            nft_id     : v1,
            nft_type   : v3,
            owner      : v0,
            start_time : v2,
        };
        0x2::event::emit<LockNFTEvent>(v11);
    }

    public entry fun withdraw_nft<T0: store + key>(arg0: &mut Metadata, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let AvatarItem {
            id         : v1,
            nft_id     : v2,
            owner      : v3,
            start_time : _,
        } = 0x2::dynamic_object_field::remove<address, AvatarItem>(&mut arg0.id, v0);
        let v5 = v1;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(&mut v5, true), v0);
        0x2::object::delete(v5);
        let v6 = WithdrawNFTEvent{
            nft_id        : v2,
            nft_type      : get_token_name<T0>(),
            owner         : v3,
            withdraw_time : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<WithdrawNFTEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

