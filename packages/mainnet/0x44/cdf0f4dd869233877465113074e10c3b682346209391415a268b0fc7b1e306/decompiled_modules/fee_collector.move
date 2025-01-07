module 0x44cdf0f4dd869233877465113074e10c3b682346209391415a268b0fc7b1e306::fee_collector {
    struct FeeCollectorConfig has key {
        id: 0x2::object::UID,
        admin: address,
        fee_recipient: address,
    }

    struct FeeCollectedEvent has copy, drop {
        chain_id: u64,
        amount: u64,
        recipient: address,
    }

    struct AdminChangedEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct FeeRecipientChangedEvent has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    public entry fun change_admin(arg0: &mut FeeCollectorConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
        let v0 = AdminChangedEvent{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminChangedEvent>(v0);
    }

    public entry fun change_fee_recipient(arg0: &mut FeeCollectorConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.fee_recipient = arg1;
        let v0 = FeeRecipientChangedEvent{
            old_recipient : arg0.fee_recipient,
            new_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientChangedEvent>(v0);
    }

    public entry fun collect_fee(arg0: &0x44cdf0f4dd869233877465113074e10c3b682346209391415a268b0fc7b1e306::fee_manager::FeeConfig, arg1: &FeeCollectorConfig, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x44cdf0f4dd869233877465113074e10c3b682346209391415a268b0fc7b1e306::fee_manager::get_fee(arg0, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v0, 0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v0, arg4), arg1.fee_recipient);
            let v1 = FeeCollectedEvent{
                chain_id  : arg2,
                amount    : v0,
                recipient : arg1.fee_recipient,
            };
            0x2::event::emit<FeeCollectedEvent>(v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorConfig{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            fee_recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeCollectorConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

