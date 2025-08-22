module 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    struct StopByFunderEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
    }

    struct CreateVaultEvent has copy, drop, store {
        bot_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        funder: address,
    }

    struct BotVaultCap has store {
        bot_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    struct Bot<T0: store + key> has store, key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<T0>,
        vault_cap: 0x1::option::Option<BotVaultCap>,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        funder: address,
        close_position: bool,
        tokens: vector<0x1::type_name::TypeName>,
        cex_deposit_address: address,
    }

    public(friend) fun borrow_cap<T0: store + key>(arg0: &Bot<T0>) : &BotVaultCap {
        0x1::option::borrow<BotVaultCap>(&arg0.vault_cap)
    }

    public fun borrow_position<T0: store + key>(arg0: &Bot<T0>) : &T0 {
        0x1::option::borrow<T0>(&arg0.position)
    }

    public fun borrow_position_mut<T0: store + key>(arg0: &mut Bot<T0>) : &mut T0 {
        0x1::option::borrow_mut<T0>(&mut arg0.position)
    }

    public fun create_bot<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : Bot<T0> {
        assert!(0x2::package::from_package<Bot<T0>>(arg0), 13906834384796778495);
        Bot<T0>{
            id        : 0x2::object::new(arg1),
            position  : 0x1::option::none<T0>(),
            vault_cap : 0x1::option::none<BotVaultCap>(),
        }
    }

    public fun create_vault<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut Bot<T0>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : Vault {
        assert!(0x2::package::from_module<Vault>(arg0), 13906834453516255231);
        let v0 = Vault{
            id                  : 0x2::object::new(arg4),
            funder              : arg2,
            close_position      : false,
            tokens              : 0x1::vector::empty<0x1::type_name::TypeName>(),
            cex_deposit_address : arg3,
        };
        let v1 = BotVaultCap{
            bot_id   : 0x2::object::id<Bot<T0>>(arg1),
            vault_id : 0x2::object::id<Vault>(&v0),
        };
        0x1::option::fill<BotVaultCap>(&mut arg1.vault_cap, v1);
        let v2 = CreateVaultEvent{
            bot_id   : 0x2::object::id<Bot<T0>>(arg1),
            vault_id : 0x2::object::id<Vault>(&v0),
            funder   : arg2,
        };
        0x2::event::emit<CreateVaultEvent>(v2);
        v0
    }

    public(friend) fun extract_position<T0: store + key>(arg0: &mut Bot<T0>) : T0 {
        0x1::option::extract<T0>(&mut arg0.position)
    }

    public(friend) fun fill_position<T0: store + key>(arg0: &mut Bot<T0>, arg1: T0) {
        0x1::option::fill<T0>(&mut arg0.position, arg1);
    }

    public fun has_position<T0: store + key>(arg0: &Bot<T0>) : bool {
        0x1::option::is_some<T0>(&arg0.position)
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BOT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_empty(arg0: &Vault) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.tokens)) {
            if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.tokens, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun stop_by_funder(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.funder == 0x2::tx_context::sender(arg1), 4);
        arg0.close_position = true;
        let v0 = StopByFunderEvent{vault_id: 0x2::object::id<Vault>(arg0)};
        0x2::event::emit<StopByFunderEvent>(v0);
    }

    public fun validate_bot_vault<T0: store + key>(arg0: &Bot<T0>, arg1: &Vault) {
        assert!(0x1::option::borrow<BotVaultCap>(&arg0.vault_cap).vault_id == 0x2::object::id<Vault>(arg1), 3);
    }

    public fun vault_available_amount<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        }
    }

    public fun vault_available_amounts<T0, T1>(arg0: &Vault) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        };
        let v3 = if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
            0
        } else {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, v1))
        };
        (v2, v3)
    }

    public fun vault_cex_deposit_address(arg0: &Vault) : address {
        arg0.cex_deposit_address
    }

    public(friend) fun vault_check_out<T0, T1>(arg0: &BotVaultCap, arg1: &mut Vault, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 13906834784228737023);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0) && 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.id, v0)) >= arg2, 1);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v1) && 0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg1.id, v1)) >= arg3, 2);
        (0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), arg2), 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.id, v1), arg3))
    }

    public fun vault_close_position(arg0: &Vault) : bool {
        arg0.close_position
    }

    public fun vault_deposit<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.tokens, v0);
        } else {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        };
    }

    public fun vault_withdraw<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.funder == 0x2::tx_context::sender(arg1), 4);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 5);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

