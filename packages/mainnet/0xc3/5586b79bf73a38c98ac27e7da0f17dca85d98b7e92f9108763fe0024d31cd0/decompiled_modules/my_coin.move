module 0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalState has key {
        id: 0x2::object::UID,
        paused: bool,
        frozen_accounts: vector<address>,
        admin: address,
    }

    struct MintEvent has copy, drop {
        to: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        from: address,
        amount: u64,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
    }

    struct FreezeEvent has copy, drop {
        account: address,
        frozen: bool,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AirdropEvent has copy, drop {
        recipients: vector<address>,
        amounts: vector<u64>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: 0x2::coin::Coin<MY_COIN>, arg2: &GlobalState, arg3: &0x2::tx_context::TxContext) {
        check_not_paused(arg2);
        0x2::coin::burn<MY_COIN>(arg0, arg1);
        let v0 = BurnEvent{
            from   : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<MY_COIN>(&arg1),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: &GlobalState, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::supply_value<MY_COIN>(0x2::coin::supply<MY_COIN>(arg0)) + arg2 <= 8000000000000000000, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg0, arg2, arg4), arg3);
        let v0 = MintEvent{
            to     : arg3,
            amount : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun transfer(arg0: 0x2::coin::Coin<MY_COIN>, arg1: address, arg2: &GlobalState, arg3: &0x2::tx_context::TxContext) {
        check_not_paused(arg2);
        check_not_frozen(0x2::tx_context::sender(arg3), arg2);
        check_not_frozen(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(arg0, arg1);
        let v0 = TransferEvent{
            from   : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : 0x2::coin::value<MY_COIN>(&arg0),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public fun airdrop(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: &GlobalState, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0);
        let v1 = 0;
        while (v1 < v0) {
            transfer(0x2::coin::mint<MY_COIN>(arg0, *0x1::vector::borrow<u64>(&arg3, v1), arg4), *0x1::vector::borrow<address>(&arg2, v1), arg1, arg4);
            v1 = v1 + 1;
        };
        let v2 = AirdropEvent{
            recipients : arg2,
            amounts    : arg3,
        };
        0x2::event::emit<AirdropEvent>(v2);
    }

    public fun batch_transfer(arg0: vector<0x2::coin::Coin<MY_COIN>>, arg1: vector<address>, arg2: &GlobalState, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<0x2::coin::Coin<MY_COIN>>(&arg0), 0);
        let v1 = 0;
        while (v1 < v0) {
            transfer(0x1::vector::remove<0x2::coin::Coin<MY_COIN>>(&mut arg0, 0), *0x1::vector::borrow<address>(&arg1, v1), arg2, arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<MY_COIN>>(arg0);
    }

    fun check_admin(arg0: &GlobalState, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    fun check_not_frozen(arg0: address, arg1: &GlobalState) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1.frozen_accounts)) {
            if (*0x1::vector::borrow<address>(&arg1.frozen_accounts, v0) == arg0) {
                abort 3
            };
            v0 = v0 + 1;
        };
    }

    fun check_not_paused(arg0: &GlobalState) {
        assert!(!arg0.paused, 4);
    }

    public fun current_admin(arg0: &GlobalState) : address {
        arg0.admin
    }

    public fun freeze_account(arg0: &AdminCap, arg1: &mut GlobalState, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check_admin(arg1, arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1.frozen_accounts)) {
            if (*0x1::vector::borrow<address>(&arg1.frozen_accounts, v0) == arg2) {
                return
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<address>(&mut arg1.frozen_accounts, arg2);
        let v1 = FreezeEvent{
            account : arg2,
            frozen  : true,
        };
        0x2::event::emit<FreezeEvent>(v1);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 9, b"RPS", b"Sui-RPS", b"Rock Paper Scissors on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(&mut v2, 8000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = GlobalState{
            id              : 0x2::object::new(arg1),
            paused          : false,
            frozen_accounts : vector[],
            admin           : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<GlobalState>(v3, 0x2::tx_context::sender(arg1));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MY_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun is_frozen(arg0: address, arg1: &GlobalState) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1.frozen_accounts)) {
            if (*0x1::vector::borrow<address>(&arg1.frozen_accounts, v0) == arg0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_paused(arg0: &GlobalState) : bool {
        arg0.paused
    }

    public fun pause(arg0: &AdminCap, arg1: &mut GlobalState, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg1, arg2);
        arg1.paused = true;
        let v0 = PauseEvent{paused: true};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun set_admin(arg0: &AdminCap, arg1: &mut GlobalState, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 1);
        arg1.admin = arg2;
        let v0 = AdminTransferred{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun total_supply(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>) : u64 {
        0x2::balance::supply_value<MY_COIN>(0x2::coin::supply<MY_COIN>(arg0))
    }

    public fun unfreeze_account(arg0: &AdminCap, arg1: &mut GlobalState, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check_admin(arg1, arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1.frozen_accounts)) {
            if (*0x1::vector::borrow<address>(&arg1.frozen_accounts, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg1.frozen_accounts, v0);
                let v1 = FreezeEvent{
                    account : arg2,
                    frozen  : false,
                };
                0x2::event::emit<FreezeEvent>(v1);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut GlobalState, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg1, arg2);
        arg1.paused = false;
        let v0 = PauseEvent{paused: false};
        0x2::event::emit<PauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

