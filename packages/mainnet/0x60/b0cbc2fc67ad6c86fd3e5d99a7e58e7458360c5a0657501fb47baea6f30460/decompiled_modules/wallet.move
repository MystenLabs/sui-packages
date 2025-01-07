module 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet {
    struct Wallet has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        version: u64,
    }

    struct DepositEvent has copy, drop {
        wallet: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        from: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        wallet: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        to: address,
        amount: u64,
    }

    struct WALLET has drop {
        dummy_field: bool,
    }

    public fun balance<T0>(arg0: &Wallet) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun assert_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 10004);
    }

    fun assert_version(arg0: &Wallet) {
        assert!(arg0.version == 1, 10001);
    }

    public fun borrow_version(arg0: &Wallet) : &u64 {
        &arg0.version
    }

    public entry fun create_wallet(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = init_wallet(arg0);
        0x2::transfer::public_transfer<Wallet>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit<T0>(arg0: &mut Wallet, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&mut arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v1 = DepositEvent{
            wallet    : 0x2::object::id<Wallet>(arg0),
            coin_type : v0,
            from      : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public entry fun deposit_with_amount<T0>(arg0: &mut Wallet, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_amount<T0>(&arg1, arg2);
        if (0x2::coin::value<T0>(&arg1) > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) - arg2, arg3), 0x2::tx_context::sender(arg3));
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&mut arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v1 = DepositEvent{
            wallet    : 0x2::object::id<Wallet>(arg0),
            coin_type : v0,
            from      : 0x2::tx_context::sender(arg3),
            amount    : arg2,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: WALLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WALLET>(arg0, arg1);
        let v1 = 0x2::display::new<Wallet>(&v0, arg1);
        0x2::display::add<Wallet>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Wallet>(&mut v1, 0x1::string::utf8(b"version"), 0x1::string::utf8(b"{version}"));
        0x2::display::update_version<Wallet>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Wallet>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_wallet(arg0: &mut 0x2::tx_context::TxContext) : Wallet {
        Wallet{
            id      : 0x2::object::new(arg0),
            name    : 0x1::string::utf8(b"wallet"),
            version : 1,
        }
    }

    public entry fun migrate(arg0: &mut Wallet) {
        assert!(arg0.version < 1, 10002);
        arg0.version = 1;
    }

    public entry fun set_name(arg0: &mut Wallet, arg1: vector<u8>) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    public fun version() : u64 {
        1
    }

    public entry fun withdraw<T0>(arg0: &mut Wallet, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&mut arg0.id, v0), 10003);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 10004);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, arg2, arg3), arg1);
        let v2 = WithdrawEvent{
            wallet    : 0x2::object::id<Wallet>(arg0),
            coin_type : v0,
            to        : arg1,
            amount    : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

