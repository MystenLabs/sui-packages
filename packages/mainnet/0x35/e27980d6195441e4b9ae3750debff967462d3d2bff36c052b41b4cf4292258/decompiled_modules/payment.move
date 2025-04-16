module 0x35e27980d6195441e4b9ae3750debff967462d3d2bff36c052b41b4cf4292258::payment {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentConfig has key {
        id: 0x2::object::UID,
        fee_recipient: address,
        default_fee_percentage: u8,
    }

    struct ConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        update_type: vector<u8>,
        admin: address,
    }

    struct SuperchatSent<phantom T0> has copy, drop {
        sender: address,
        recipient: address,
        total_amount: u64,
        fee_amount: u64,
        recipient_amount: u64,
        config_id: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = PaymentConfig{
            id                     : 0x2::object::new(arg0),
            fee_recipient          : v1,
            default_fee_percentage : 5,
        };
        let v3 = ConfigUpdated{
            config_id   : 0x2::object::id<PaymentConfig>(&v2),
            update_type : b"initialized",
            admin       : v1,
        };
        0x2::event::emit<ConfigUpdated>(v3);
        0x2::transfer::transfer<AdminCap>(v0, v1);
        0x2::transfer::share_object<PaymentConfig>(v2);
    }

    public entry fun process_superchat_payment<T0>(arg0: &PaymentConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::split<T0>(&mut arg1, arg2, arg4);
        let v2 = arg2 * (arg0.default_fee_percentage as u64) / 100;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v2, arg4), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v3 = SuperchatSent<T0>{
            sender           : v0,
            recipient        : arg3,
            total_amount     : arg2,
            fee_amount       : v2,
            recipient_amount : arg2 - v2,
            config_id        : 0x2::object::id<PaymentConfig>(arg0),
        };
        0x2::event::emit<SuperchatSent<T0>>(v3);
    }

    public entry fun update_default_fee_percentage(arg0: &AdminCap, arg1: &mut PaymentConfig, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 1);
        arg1.default_fee_percentage = arg2;
        let v0 = ConfigUpdated{
            config_id   : 0x2::object::id<PaymentConfig>(arg1),
            update_type : b"fee_percentage_updated",
            admin       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public entry fun update_fee_recipient(arg0: &AdminCap, arg1: &mut PaymentConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_recipient = arg2;
        let v0 = ConfigUpdated{
            config_id   : 0x2::object::id<PaymentConfig>(arg1),
            update_type : b"fee_recipient_updated",
            admin       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

