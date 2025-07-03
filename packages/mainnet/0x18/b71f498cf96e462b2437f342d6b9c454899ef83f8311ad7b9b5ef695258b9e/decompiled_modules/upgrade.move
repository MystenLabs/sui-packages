module 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::upgrade {
    struct UPGRADE has drop {
        dummy_field: bool,
    }

    struct Upgrades<phantom T0> has key {
        id: 0x2::object::UID,
        upgrade_price: u64,
    }

    public fun add_upgrade<T0>(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg2);
        let v0 = Upgrades<T0>{
            id            : 0x2::object::new(arg2),
            upgrade_price : arg1,
        };
        0x2::transfer::share_object<Upgrades<T0>>(v0);
    }

    fun init(arg0: UPGRADE, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun update_upgrade_price_admin<T0>(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut Upgrades<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg3);
        arg1.upgrade_price = arg2;
    }

    public fun upgrade_kila<T0>(arg0: &Upgrades<T0>, arg1: &mut 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x2::coin::Coin<T0>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg10) > 0, 1);
        assert!(0x2::coin::value<T0>(&arg10) == arg0.upgrade_price, 2);
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::upgrade_pfp(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg10, @0x73e82e0c4c5f25a3607e4a58ce6b178c2ce77f568508fa65b03a9157d5144a1f);
    }

    // decompiled from Move bytecode v6
}

