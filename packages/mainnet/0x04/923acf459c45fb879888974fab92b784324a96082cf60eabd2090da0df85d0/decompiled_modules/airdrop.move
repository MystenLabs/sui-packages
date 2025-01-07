module 0x4923acf459c45fb879888974fab92b784324a96082cf60eabd2090da0df85d0::airdrop {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        tracked_user_ids: 0x2::table::Table<0x1::string::String, bool>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AirDropEvent has copy, drop {
        user_id: 0x1::string::String,
        user_address: address,
        amount: u64,
    }

    public entry fun deposit(arg0: &mut Vault, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg4)));
        0x4923acf459c45fb879888974fab92b784324a96082cf60eabd2090da0df85d0::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Vault{
            id               : 0x2::object::new(arg0),
            tracked_user_ids : 0x2::table::new<0x1::string::String, bool>(arg0),
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault>(v1);
    }

    public entry fun transfer_airdrop(arg0: &mut Vault, arg1: &AdminCap, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.tracked_user_ids, arg3), 1001);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg5), arg4);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.tracked_user_ids, arg3, true);
        let v0 = AirDropEvent{
            user_id      : arg3,
            user_address : arg4,
            amount       : arg2,
        };
        0x2::event::emit<AirDropEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

