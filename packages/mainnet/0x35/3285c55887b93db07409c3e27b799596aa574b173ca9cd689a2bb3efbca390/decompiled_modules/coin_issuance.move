module 0x353285c55887b93db07409c3e27b799596aa574b173ca9cd689a2bb3efbca390::coin_issuance {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ServiceProvider has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CoinOperation has copy, drop {
        authority: address,
        coin_type: 0x1::string::String,
        operation: 0x1::string::String,
    }

    public entry fun collect_profits(arg0: &OwnerCap, arg1: &mut ServiceProvider, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun emit_coin_operation<T0: drop>(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = CoinOperation{
            authority : 0x2::tx_context::sender(arg1),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())),
            operation : 0x1::string::utf8(arg0),
        };
        0x2::event::emit<CoinOperation>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ServiceProvider{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<ServiceProvider>(v1);
    }

    public entry fun pay_for_service(arg0: &mut ServiceProvider, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
    }

    public entry fun transfer_owner_cap(arg0: OwnerCap, arg1: address) {
        0x2::transfer::public_transfer<OwnerCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

