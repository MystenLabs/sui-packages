module 0x934692a74595c4f5a0c026130eb2143eea6fc313742f5d7dd9e45fd6ddbb00f1::suime {
    struct SUIME has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUIME>,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        amount: u64,
        balance: 0x2::balance::Balance<SUIME>,
        unlock_time_ms: u64,
        is_claimed: bool,
    }

    struct LockInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        amount: u64,
        unlock_time_ms: u64,
        is_claimed: bool,
    }

    public entry fun burn(arg0: &mut Global, arg1: 0x2::coin::Coin<SUIME>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<SUIME>(&arg1) >= arg2, 2);
        0x2::coin::burn<SUIME>(&mut arg0.treasury_cap, 0x2::coin::split<SUIME>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<SUIME>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIME>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIME>(arg1);
        };
    }

    fun init(arg0: SUIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://app-belaunch.infura-ipfs.io/ipfs/QmWF1Gzk3DwmbXrEMSntEEhCCSj39ZKRgBWeSTpDkHXZrL"));
        let v1 = 0x2::tx_context::sender(arg1);
        let (v2, v3) = 0x2::coin::create_currency<SUIME>(arg0, 6, b"SUIME", b"SUIME", b"$SUIME #1 memecoin on SuiNetwork. Suime is not just a meme, it's a movement! Our community is united to help Suime across the Suinami.", v0, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUIME>(&mut v4, 8000000000000000, @0xac4511e6527ceda91647164fa396ad34b4be9bc1658ce94656a90a5d6619082a, arg1);
        0x2::coin::mint_and_transfer<SUIME>(&mut v4, 2000000000000000, @0xca4f2efbbbf8c28e8ac14ecece4ce1838929ae4dde521be3986792e371dfb8db, arg1);
        0x2::coin::mint_and_transfer<SUIME>(&mut v4, 2000000000000000, @0xc83b577ee2eb7af20ca4979970d28c26446d96f7062b7a942e46a2c4ce9b23ec, arg1);
        0x2::coin::mint_and_transfer<SUIME>(&mut v4, 3000000000000000, @0xf159e2f35699ef7a7b5270c9b3b6df4361b60708bb7cfc91bd61e1f5c1eef7b5, arg1);
        0x2::coin::mint_and_transfer<SUIME>(&mut v4, 1000000000000000, @0x5be22f2202d48f835cf0378b8c02c6f5bac5ff50543d1a379ade3f350324ee60, arg1);
        0x2::coin::mint_and_transfer<SUIME>(&mut v4, 4000000000000000, @0xf3d11111309a0ecd8a1ef8910f2d824971a2ed68e939b63aefd9e1569b1ec7b9, arg1);
        let v5 = Global{
            id           : 0x2::object::new(arg1),
            treasury_cap : v4,
        };
        0x2::transfer::public_share_object<Global>(v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIME>>(v3);
        let v6 = OwnerCap{
            id    : 0x2::object::new(arg1),
            owner : v1,
        };
        0x2::transfer::transfer<OwnerCap>(v6, v1);
    }

    public entry fun lock(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<SUIME>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg1), 0);
        assert!(arg5 > 0, 1);
        assert!(0x2::coin::value<SUIME>(&arg4) >= arg5, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = Lock{
            id             : v1,
            name           : v2,
            owner          : v0,
            amount         : arg5,
            balance        : 0x2::balance::zero<SUIME>(),
            unlock_time_ms : arg3,
            is_claimed     : false,
        };
        0x2::balance::join<SUIME>(&mut v3.balance, 0x2::coin::into_balance<SUIME>(0x2::coin::split<SUIME>(&mut arg4, arg5, arg6)));
        0x2::transfer::transfer<Lock>(v3, v0);
        let v4 = LockInfo{
            id             : 0x2::object::new(arg6),
            name           : v2,
            owner          : v0,
            amount         : arg5,
            unlock_time_ms : arg3,
            is_claimed     : false,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, LockInfo>(&mut arg0.id, 0x2::object::uid_to_inner(&v1), v4);
        if (0x2::coin::value<SUIME>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIME>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<SUIME>(arg4);
        };
    }

    public fun mint(arg0: &mut Global, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIME>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    public entry fun multi_burn(arg0: &mut Global, arg1: vector<0x2::coin::Coin<SUIME>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIME>>(&mut arg1);
        0x2::pay::join_vec<SUIME>(&mut v0, arg1);
        assert!(0x2::coin::value<SUIME>(&v0) >= arg2, 2);
        0x2::coin::burn<SUIME>(&mut arg0.treasury_cap, 0x2::coin::split<SUIME>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIME>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIME>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIME>(v0);
        };
    }

    public entry fun renounce_ownership(arg0: OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let OwnerCap {
            id    : v0,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun renounce_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::make_immutable(arg0);
    }

    public entry fun transfer_ownership(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg1;
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public entry fun unlock(arg0: &mut Global, arg1: &mut Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_claimed, 3);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_time_ms, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIME>>(0x2::coin::take<SUIME>(&mut arg1.balance, 0x2::balance::value<SUIME>(&arg1.balance), arg3), arg1.owner);
        arg1.is_claimed = true;
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, LockInfo>(&mut arg0.id, 0x2::object::uid_to_inner(&arg1.id)).is_claimed = true;
    }

    // decompiled from Move bytecode v6
}

