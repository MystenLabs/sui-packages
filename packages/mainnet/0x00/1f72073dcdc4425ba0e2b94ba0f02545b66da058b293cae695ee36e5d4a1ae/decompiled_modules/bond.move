module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond {
    struct ScaleBond<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        mint_time: u64,
        face_value: 0x2::balance::Balance<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::LSP<T0, T1>>,
        issue_expiration_time: u64,
        market_id: 0x2::object::ID,
    }

    struct ScaleNFTFactory has key {
        id: 0x2::object::UID,
        mould: 0x2::table::Table<0x1::string::String, ScaleNFTItem>,
    }

    struct ScaleNFTItem has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MoveToken has store {
        nft_id: 0x2::object::ID,
        expiration_time: u64,
    }

    struct UpgradeMoveToken has store, key {
        id: 0x2::object::UID,
        move_token: MoveToken,
    }

    public fun add_factory_mould(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &mut ScaleNFTFactory, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 401);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 402);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 403);
        let v0 = 0x1::string::utf8(arg2);
        let v1 = ScaleNFTItem{
            name        : v0,
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        0x2::table::add<0x1::string::String, ScaleNFTItem>(&mut arg1.mould, v0, v1);
    }

    public fun divestment<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: ScaleBond<T0, T1>, arg2: 0x1::option::Option<MoveToken>, arg3: &mut 0x2::tx_context::TxContext) {
        let ScaleBond {
            id                    : v0,
            name                  : _,
            description           : _,
            url                   : _,
            mint_time             : _,
            face_value            : v5,
            issue_expiration_time : _,
            market_id             : v7,
        } = arg1;
        let v8 = v0;
        assert!(v7 == 0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(arg0), 405);
        if (0x1::option::is_some<MoveToken>(&arg2)) {
            let MoveToken {
                nft_id          : v9,
                expiration_time : _,
            } = 0x1::option::destroy_some<MoveToken>(arg2);
            assert!(0x2::object::uid_to_inner(&v8) == v9, 404);
        } else {
            0x1::option::destroy_none<MoveToken>(arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::remove_liquidity<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(arg0), v5, arg3), 0x2::tx_context::sender(arg3));
        0x2::object::delete(v8);
    }

    public fun divestment_by_upgrade<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: ScaleBond<T0, T1>, arg2: UpgradeMoveToken, arg3: &mut 0x2::tx_context::TxContext) {
        let UpgradeMoveToken {
            id         : v0,
            move_token : v1,
        } = arg2;
        divestment<T0, T1>(arg0, arg1, 0x1::option::some<MoveToken>(v1), arg3);
        0x2::object::delete(v0);
    }

    public fun generate_move_token<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &ScaleBond<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : MoveToken {
        MoveToken{
            nft_id          : 0x2::object::uid_to_inner(&arg1.id),
            expiration_time : arg2,
        }
    }

    public fun generate_upgrade_move_token<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &ScaleBond<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = UpgradeMoveToken{
            id         : v0,
            move_token : generate_move_token<T0, T1>(arg0, arg1, arg2, arg4),
        };
        0x2::transfer::transfer<UpgradeMoveToken>(v1, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScaleNFTFactory{
            id    : 0x2::object::new(arg0),
            mould : 0x2::table::new<0x1::string::String, ScaleNFTItem>(arg0),
        };
        0x2::transfer::share_object<ScaleNFTFactory>(v0);
    }

    public fun investment<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut ScaleNFTFactory, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        if (arg4 == 0) {
            0x2::coin::join<T1>(&mut v0, arg1);
        } else {
            assert!(arg4 <= 0x2::coin::value<T1>(&arg1), 406);
            0x2::coin::join<T1>(&mut v0, 0x2::coin::split<T1>(&mut arg1, arg4, arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
        };
        let v1 = 0x2::table::borrow<0x1::string::String, ScaleNFTItem>(&arg2.mould, 0x1::string::utf8(arg3));
        let v2 = 0x2::object::new(arg5);
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg2.id, 0x2::object::uid_to_inner(&v2), true);
        let v3 = ScaleBond<T0, T1>{
            id                    : v2,
            name                  : v1.name,
            description           : v1.description,
            url                   : v1.url,
            mint_time             : 0,
            face_value            : 0x2::coin::into_balance<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::LSP<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::add_liquidity<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_pool_mut<T0, T1>(arg0), v0, arg5)),
            issue_expiration_time : 0,
            market_id             : 0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(arg0),
        };
        0x2::transfer::transfer<ScaleBond<T0, T1>>(v3, 0x2::tx_context::sender(arg5));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x2::object::id<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(arg0));
    }

    public fun remove_factory_mould(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &mut ScaleNFTFactory, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 401);
        let ScaleNFTItem {
            name        : _,
            description : _,
            url         : _,
        } = 0x2::table::remove<0x1::string::String, ScaleNFTItem>(&mut arg1.mould, 0x1::string::utf8(arg2));
    }

    // decompiled from Move bytecode v6
}

