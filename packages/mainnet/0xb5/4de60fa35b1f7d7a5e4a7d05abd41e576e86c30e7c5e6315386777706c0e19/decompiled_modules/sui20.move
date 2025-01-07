module 0xb54de60fa35b1f7d7a5e4a7d05abd41e576e86c30e7c5e6315386777706c0e19::sui20 {
    struct SUI20 has drop {
        dummy_field: bool,
    }

    struct ModuleData has store, key {
        id: 0x2::object::UID,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct DeployData has store {
        tick: 0x1::string::String,
        module_id: address,
        share_id: address,
        total_epoch: u64,
        epoch_duration: u64,
        epoch_token: u64,
        reward_epoch: u64,
        total_token: u64,
    }

    struct InscriptionSui20DeployEvent has copy, drop {
        module_id: address,
        share_id: address,
        tick: 0x1::string::String,
        total_epoch: u64,
        epoch_duration: u64,
        epoch_token: u64,
        reward_epoch: u64,
        total_token: u64,
        winner_epoch_reward: u64,
        deployer: address,
    }

    struct MintEvent has copy, drop {
        tick: 0x1::string::String,
        epoch: u64,
        sender: address,
        user_mint_count: u64,
        epoch_mint_count: u64,
        tick_mint_count: u64,
    }

    struct SettlementEvent has copy, drop {
        tick: 0x1::string::String,
        epoch: u64,
        owner: address,
        user_mint_count: u64,
        minted_token: u64,
        reward_token: u64,
        is_done: bool,
    }

    public entry fun deploy_sui20(arg0: &mut ModuleData, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_with_type<0x1::string::String, DeployData>(&arg0.id, arg2), 0);
        let v0 = DeployData{
            tick           : arg2,
            module_id      : arg1,
            share_id       : arg9,
            total_epoch    : arg3,
            epoch_duration : arg4,
            epoch_token    : arg5,
            reward_epoch   : arg6,
            total_token    : arg7,
        };
        0x2::dynamic_field::add<0x1::string::String, DeployData>(&mut arg0.id, arg2, v0);
        let v1 = InscriptionSui20DeployEvent{
            module_id           : arg1,
            share_id            : arg9,
            tick                : arg2,
            total_epoch         : arg3,
            epoch_duration      : arg4,
            epoch_token         : arg5,
            reward_epoch        : arg6,
            total_token         : arg7,
            winner_epoch_reward : arg8,
            deployer            : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<InscriptionSui20DeployEvent>(v1);
    }

    fun init(arg0: SUI20, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SUI20>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = ModuleData{
            id      : 0x2::object::new(arg1),
            fee     : 100000000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            admin   : @0x57185dfd2c4ed44e95ccf6375d8ffb3081a80191480fc162b08d6457e57d49ac,
        };
        0x2::transfer::share_object<ModuleData>(v0);
    }

    public entry fun inscribe(arg0: &mut ModuleData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = MintEvent{
            tick             : arg2,
            epoch            : arg3,
            sender           : arg4,
            user_mint_count  : arg5,
            epoch_mint_count : arg6,
            tick_mint_count  : arg7,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun settlement_event(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(@0x57185dfd2c4ed44e95ccf6375d8ffb3081a80191480fc162b08d6457e57d49ac == 0x2::tx_context::sender(arg7), 0);
        let v0 = SettlementEvent{
            tick            : arg0,
            epoch           : arg1,
            owner           : arg2,
            user_mint_count : arg3,
            minted_token    : arg4,
            reward_token    : arg5,
            is_done         : arg6,
        };
        0x2::event::emit<SettlementEvent>(v0);
    }

    public entry fun update_fee(arg0: &mut ModuleData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.fee = arg1;
    }

    public entry fun withdraw_sui(arg0: &mut ModuleData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

