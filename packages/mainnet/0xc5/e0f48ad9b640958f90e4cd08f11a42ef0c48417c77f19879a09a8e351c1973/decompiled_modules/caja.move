module 0xc5e0f48ad9b640958f90e4cd08f11a42ef0c48417c77f19879a09a8e351c1973::caja {
    struct Caja<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        dueno: address,
        bot: address,
        creds: vector<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>,
        recompensas: 0x2::balance::Balance<T1>,
    }

    struct Prestamo {
        caja: 0x2::object::ID,
        cred: 0x2::object::ID,
        stake: u64,
        acc: u128,
        boveda: u64,
    }

    struct CajaCreada has copy, drop {
        caja: 0x2::object::ID,
        dueno: address,
        bot: address,
    }

    struct Devuelto has copy, drop {
        caja: 0x2::object::ID,
        recompensa: u64,
        capital: u64,
    }

    struct Enviado has copy, drop {
        caja: 0x2::object::ID,
        dueno: address,
        cantidad: u64,
    }

    public fun bot<T0, T1>(arg0: &Caja<T0, T1>) : address {
        arg0.bot
    }

    fun comprobar_permiso<T0, T1>(arg0: &Caja<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.bot || v0 == arg0.dueno, 1);
    }

    public fun crear<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Caja<T0, T1>{
            id          : 0x2::object::new(arg1),
            dueno       : arg0,
            bot         : 0x2::tx_context::sender(arg1),
            creds       : 0x1::vector::empty<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(),
            recompensas : 0x2::balance::zero<T1>(),
        };
        let v1 = CajaCreada{
            caja  : 0x2::object::id<Caja<T0, T1>>(&v0),
            dueno : arg0,
            bot   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CajaCreada>(v1);
        0x2::transfer::share_object<Caja<T0, T1>>(v0);
    }

    public fun devolver<T0, T1>(arg0: &mut Caja<T0, T1>, arg1: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::Pool<T0, T1>, arg2: 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>, arg3: Prestamo, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T0>) {
        let Prestamo {
            caja   : v0,
            cred   : v1,
            stake  : v2,
            acc    : v3,
            boveda : v4,
        } = arg3;
        assert!(v0 == 0x2::object::id<Caja<T0, T1>>(arg0), 2);
        assert!(0x2::object::id<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&arg2) == v1, 3);
        let v5 = 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_staked_amount<T0, T1>(&arg2);
        let v6 = 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_acc_reward_per_share<T0, T1>(&arg2);
        assert!(v5 <= v2 && 0x2::coin::value<T0>(&arg5) == v2 - v5, 4);
        assert!(v5 == v2 || v6 == 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::pool_acc_reward_per_share<T0, T1>(arg1), 6);
        let v7 = if (v6 > v3) {
            ((((v6 - v3) as u256) * (v2 as u256) / 1000000000000000000) as u64)
        } else {
            0
        };
        let v8 = 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::pool_reward_vault_value<T0, T1>(arg1);
        let v9 = if (v4 > v8) {
            v4 - v8
        } else {
            0
        };
        let v10 = 0x2::coin::value<T1>(&arg4);
        assert!(v10 >= v7 && v10 >= v9, 5);
        let v11 = 0x2::coin::value<T0>(&arg5);
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg0.dueno);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        0x2::balance::join<T1>(&mut arg0.recompensas, 0x2::coin::into_balance<T1>(arg4));
        if (v5 > 0) {
            0x1::vector::push_back<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&mut arg0.creds, arg2);
        } else {
            0x2::transfer::public_transfer<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(arg2, arg0.dueno);
        };
        let v12 = Devuelto{
            caja       : v0,
            recompensa : v10,
            capital    : v11,
        };
        0x2::event::emit<Devuelto>(v12);
    }

    public fun dueno<T0, T1>(arg0: &Caja<T0, T1>) : address {
        arg0.dueno
    }

    public fun emergencia<T0, T1>(arg0: &mut Caja<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        comprobar_permiso<T0, T1>(arg0, arg1);
        while (!0x1::vector::is_empty<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&arg0.creds)) {
            0x2::transfer::public_transfer<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(0x1::vector::pop_back<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&mut arg0.creds), arg0.dueno);
        };
        enviar<T0, T1>(arg0, arg1);
    }

    public fun enviar<T0, T1>(arg0: &mut Caja<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        comprobar_permiso<T0, T1>(arg0, arg1);
        let v0 = 0x2::balance::value<T1>(&arg0.recompensas);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.recompensas), arg1), arg0.dueno);
        let v1 = Enviado{
            caja     : 0x2::object::id<Caja<T0, T1>>(arg0),
            dueno    : arg0.dueno,
            cantidad : v0,
        };
        0x2::event::emit<Enviado>(v1);
    }

    public fun guardar<T0, T1>(arg0: &mut Caja<T0, T1>, arg1: 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        comprobar_permiso<T0, T1>(arg0, arg2);
        0x1::vector::push_back<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&mut arg0.creds, arg1);
    }

    public fun num_credenciales<T0, T1>(arg0: &Caja<T0, T1>) : u64 {
        0x1::vector::length<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&arg0.creds)
    }

    public fun prestar<T0, T1>(arg0: &mut Caja<T0, T1>, arg1: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) : (0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>, Prestamo) {
        comprobar_permiso<T0, T1>(arg0, arg3);
        assert!(arg2 < 0x1::vector::length<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&arg0.creds), 7);
        let v0 = 0x1::vector::remove<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&mut arg0.creds, arg2);
        let v1 = Prestamo{
            caja   : 0x2::object::id<Caja<T0, T1>>(arg0),
            cred   : 0x2::object::id<0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>>(&v0),
            stake  : 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_staked_amount<T0, T1>(&v0),
            acc    : 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_acc_reward_per_share<T0, T1>(&v0),
            boveda : 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::pool_reward_vault_value<T0, T1>(arg1),
        };
        (v0, v1)
    }

    public fun recompensas<T0, T1>(arg0: &Caja<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.recompensas)
    }

    // decompiled from Move bytecode v7
}

