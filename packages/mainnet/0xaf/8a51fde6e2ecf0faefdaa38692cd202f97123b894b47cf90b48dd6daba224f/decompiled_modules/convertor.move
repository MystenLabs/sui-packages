module 0x75c86bc3ce3bb66c92b88a192d27a3334a72b54edc0d874c7850ffa97ce2820b::convertor {
    struct DROP_TO_BUT has drop {
        dummy_field: bool,
    }

    struct ButConvertor has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        conversion_rate: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        is_public: bool,
        whitelist: 0x2::vec_set::VecSet<address>,
        reserve: 0x2::balance::Balance<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ConvertEvent has copy, drop {
        drop_amount_in: u64,
        but_amount_out: u64,
    }

    public fun add_version(arg0: &mut ButConvertor, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun add_whitelist(arg0: &mut ButConvertor, arg1: &AdminCap, arg2: address) {
        check_package_version(arg0);
        0x2::vec_set::insert<address>(&mut arg0.whitelist, arg2);
    }

    fun check_allowance(arg0: &ButConvertor, arg1: &0x2::tx_context::TxContext) {
        let v0 = if (arg0.is_public) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg1);
            0x2::vec_set::contains<address>(&arg0.whitelist, &v1)
        };
        assert!(v0, 102);
    }

    fun check_package_version(arg0: &ButConvertor) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 101);
    }

    public fun claim_drop_from_point_center(arg0: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP> {
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::claim<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>(arg0, arg3, arg1, arg2, arg4)
    }

    public fun claim_drop_from_reward_center(arg0: &mut 0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::reward_center::RewardCenter<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET, 0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>, arg1: &0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP> {
        0x2::coin::from_balance<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>(0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::reward_center::claim<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET, 0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>(arg0, arg1, arg2), arg3)
    }

    public fun convert_to_but(arg0: &mut ButConvertor, arg1: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>, arg2: 0x2::coin::Coin<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT> {
        check_allowance(arg0, arg3);
        check_package_version(arg0);
        let v0 = 0x2::coin::value<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP>(&arg2);
        let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(v0), arg0.conversion_rate));
        let v2 = DROP_TO_BUT{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::burn_with_witness<0x1d627cecd34128bd6fe5a067a3a590d0f62fa514fe19d2a20a31205e3d51ea55::drop::DROP, DROP_TO_BUT>(arg1, arg2, v2);
        let v3 = ConvertEvent{
            drop_amount_in : v0,
            but_amount_out : v1,
        };
        0x2::event::emit<ConvertEvent>(v3);
        0x2::coin::from_balance<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>(0x2::balance::split<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>(&mut arg0.reserve, v1), arg3)
    }

    public fun early_unlock(arg0: &mut ButConvertor, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET>, arg2: &mut 0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET>) {
        check_allowance(arg0, arg5);
        check_package_version(arg0);
        let v0 = DROP_TO_BUT{dummy_field: false};
        0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::force_unlock_with_whitelist<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET, DROP_TO_BUT>(arg2, arg1, v0, arg3, arg4, arg5)
    }

    public fun early_unlock_with_de_token(arg0: &mut ButConvertor, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET>, arg2: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET>) {
        check_allowance(arg0, arg4);
        check_package_version(arg0);
        let v0 = DROP_TO_BUT{dummy_field: false};
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::force_unlock_with_whitelist<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT, 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket::BUCKET, DROP_TO_BUT>(arg1, arg2, v0, arg3, arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ButConvertor{
            id              : 0x2::object::new(arg0),
            versions        : 0x2::vec_set::singleton<u64>(package_version()),
            conversion_rate : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(0),
            is_public       : false,
            whitelist       : 0x2::vec_set::empty<address>(),
            reserve         : 0x2::balance::zero<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>(),
        };
        0x2::transfer::share_object<ButConvertor>(v1);
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_version(arg0: &mut ButConvertor, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun remove_whitelist(arg0: &mut ButConvertor, arg1: &AdminCap, arg2: address) {
        check_package_version(arg0);
        0x2::vec_set::remove<address>(&mut arg0.whitelist, &arg2);
    }

    public fun toggle_is_public(arg0: &mut ButConvertor, arg1: &AdminCap) {
        check_package_version(arg0);
        arg0.is_public = !arg0.is_public;
    }

    public fun topup_reserve(arg0: &mut ButConvertor, arg1: 0x2::balance::Balance<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>) {
        check_package_version(arg0);
        0x2::balance::join<0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but::BUT>(&mut arg0.reserve, arg1);
    }

    public fun update_conversion_rate(arg0: &mut ButConvertor, arg1: &AdminCap, arg2: u64, arg3: u64) {
        check_package_version(arg0);
        arg0.conversion_rate = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

