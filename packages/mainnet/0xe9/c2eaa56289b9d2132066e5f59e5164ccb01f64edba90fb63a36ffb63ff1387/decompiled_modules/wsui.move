module 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    struct SupplyBag has key {
        id: 0x2::object::UID,
        wsui_supply: 0x2::balance::Supply<WSUI>,
        coin: 0x2::balance::Balance<0x2::sui::SUI>,
        has_paused: bool,
        controller: address,
        beneficiary: address,
    }

    public(friend) fun beneficiary(arg0: &SupplyBag) : address {
        arg0.beneficiary
    }

    public(friend) fun controller(arg0: &SupplyBag) : address {
        arg0.controller
    }

    public entry fun deposit(arg0: &mut SupplyBag, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg1), 105);
        assert!(arg2 > 0, 107);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg1);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut v0, arg2, arg3);
        let v2 = deposit_(arg0, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<WSUI>>(v2, 0x2::tx_context::sender(arg3));
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public fun deposit_(arg0: &mut SupplyBag, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WSUI> {
        assert!(!is_emergency(arg0), 102);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 106);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.coin, v0);
        0x2::coin::from_balance<WSUI>(0x2::balance::increase_supply<WSUI>(&mut arg0.wsui_supply, 0x2::balance::value<0x2::sui::SUI>(&v0)), arg2)
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 9, b"WSUI", b"WSUI", b"Wrapped SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suidex.io/metadata/SUID.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WSUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = SupplyBag{
            id          : 0x2::object::new(arg1),
            wsui_supply : 0x2::coin::treasury_into_supply<WSUI>(v2),
            coin        : 0x2::balance::zero<0x2::sui::SUI>(),
            has_paused  : false,
            controller  : @0x53b9ae07ee8f4000851765b329c6402bfddcf1476e70952d3c7c3614735b2c28,
            beneficiary : @0x53b9ae07ee8f4000851765b329c6402bfddcf1476e70952d3c7c3614735b2c28,
        };
        0x2::transfer::share_object<SupplyBag>(v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    public(friend) fun is_emergency(arg0: &SupplyBag) : bool {
        arg0.has_paused
    }

    public(friend) fun modify_controller(arg0: &mut SupplyBag, arg1: address) {
        arg0.controller = arg1;
    }

    public(friend) fun pause(arg0: &mut SupplyBag) {
        arg0.has_paused = true;
    }

    public(friend) fun resume(arg0: &mut SupplyBag) {
        arg0.has_paused = false;
    }

    public entry fun withdraw(arg0: &mut SupplyBag, arg1: vector<0x2::coin::Coin<WSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<WSUI>>(&arg1), 105);
        assert!(arg2 > 0, 109);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<WSUI>>(&mut arg1);
        0x2::pay::join_vec<WSUI>(&mut v0, arg1);
        let v1 = 0x2::coin::split<WSUI>(&mut v0, arg2, arg3);
        let v2 = withdraw_(arg0, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg3));
        if (0x2::coin::value<WSUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WSUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<WSUI>(v0);
        };
    }

    public fun withdraw_(arg0: &mut SupplyBag, arg1: 0x2::coin::Coin<WSUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!is_emergency(arg0), 102);
        assert!(0x2::coin::value<WSUI>(&arg1) > 0, 108);
        let v0 = 0x2::coin::into_balance<WSUI>(arg1);
        0x2::balance::decrease_supply<WSUI>(&mut arg0.wsui_supply, v0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.coin, 0x2::balance::value<WSUI>(&v0), arg2)
    }

    public(friend) fun withdraw_coin(arg0: &mut SupplyBag, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.coin);
        assert!(v0 > 0 && v0 > arg1, 0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.coin, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

