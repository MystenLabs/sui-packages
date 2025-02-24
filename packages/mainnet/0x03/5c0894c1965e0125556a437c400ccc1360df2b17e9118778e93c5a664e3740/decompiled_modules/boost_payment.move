module 0x35c0894c1965e0125556a437c400ccc1360df2b17e9118778e93c5a664e3740::boost_payment {
    struct Config has store, key {
        id: 0x2::object::UID,
        setter: address,
        pay_to: address,
        boost_option: 0x2::vec_map::VecMap<u64, BoostOption>,
    }

    struct ManageConfig has store, key {
        id: 0x2::object::UID,
        pay_to: address,
        fee: u64,
        is_live: bool,
    }

    struct BoostOption has copy, drop, store {
        index: u64,
        duration: u64,
        boost: u64,
        amount_sui: u64,
    }

    struct PaymentEvent has copy, drop, store {
        user: address,
        coin_type: 0x1::ascii::String,
        start_time: u64,
        end_time: u64,
        boost: u64,
        amount_sui: u64,
    }

    struct MessageEvent has copy, drop, store {
        user: address,
        coin_type: 0x1::ascii::String,
        message: 0x1::ascii::String,
        start_time: u64,
        image_url: 0x1::option::Option<0x1::ascii::String>,
    }

    struct UpdateTokenProfileEvent has copy, drop, store {
        user: address,
        coin_type: 0x1::ascii::String,
        web_site: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        description: 0x1::ascii::String,
        logo_image: 0x1::ascii::String,
    }

    public entry fun create_manage_config(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        let v0 = ManageConfig{
            id      : 0x2::object::new(arg2),
            pay_to  : arg0,
            fee     : arg1,
            is_live : true,
        };
        0x2::transfer::public_share_object<ManageConfig>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<u64, BoostOption>();
        let v1 = BoostOption{
            index      : 0,
            duration   : 86400,
            boost      : 10,
            amount_sui : 990000000,
        };
        let v2 = BoostOption{
            index      : 1,
            duration   : 86400,
            boost      : 30,
            amount_sui : 2450000000,
        };
        let v3 = BoostOption{
            index      : 2,
            duration   : 86400,
            boost      : 50,
            amount_sui : 3990000000,
        };
        let v4 = BoostOption{
            index      : 3,
            duration   : 86400,
            boost      : 100,
            amount_sui : 7490000000,
        };
        let v5 = BoostOption{
            index      : 4,
            duration   : 86400,
            boost      : 500,
            amount_sui : 35900000000,
        };
        let v6 = 0x1::vector::empty<BoostOption>();
        let v7 = &mut v6;
        0x1::vector::push_back<BoostOption>(v7, v1);
        0x1::vector::push_back<BoostOption>(v7, v2);
        0x1::vector::push_back<BoostOption>(v7, v3);
        0x1::vector::push_back<BoostOption>(v7, v4);
        0x1::vector::push_back<BoostOption>(v7, v5);
        let v8 = 0;
        while (v8 < 0x1::vector::length<BoostOption>(&v6)) {
            let v9 = 0x1::vector::pop_back<BoostOption>(&mut v6);
            0x2::vec_map::insert<u64, BoostOption>(&mut v0, v9.index, v9);
            v8 = v8 + 1;
        };
        let v10 = Config{
            id           : 0x2::object::new(arg0),
            setter       : @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f,
            pay_to       : @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f,
            boost_option : v0,
        };
        0x2::transfer::public_share_object<Config>(v10);
    }

    public entry fun pay<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get<u64, BoostOption>(&arg0.boost_option, &arg2);
        assert!(v0.amount_sui <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 3);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.pay_to);
        let v2 = PaymentEvent{
            user       : 0x2::tx_context::sender(arg4),
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            start_time : v1,
            end_time   : v1 + v0.duration,
            boost      : v0.boost,
            amount_sui : v0.amount_sui,
        };
        0x2::event::emit<PaymentEvent>(v2);
    }

    public entry fun replace_boost_options(arg0: &mut Config, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.setter || v0 == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        while (!0x2::vec_map::is_empty<u64, BoostOption>(&arg0.boost_option)) {
            let (_, _) = 0x2::vec_map::pop<u64, BoostOption>(&mut arg0.boost_option);
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg2)) {
            let v4 = BoostOption{
                index      : v3,
                duration   : *0x1::vector::borrow<u64>(&arg1, v3),
                boost      : *0x1::vector::borrow<u64>(&arg2, v3),
                amount_sui : *0x1::vector::borrow<u64>(&arg3, v3),
            };
            0x2::vec_map::insert<u64, BoostOption>(&mut arg0.boost_option, v3, v4);
            v3 = v3 + 1;
        };
    }

    public entry fun send_message<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<0x1::ascii::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.pay_to);
        let v0 = MessageEvent{
            user       : 0x2::tx_context::sender(arg5),
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            message    : arg2,
            start_time : 0x2::clock::timestamp_ms(arg4) / 1000,
            image_url  : arg3,
        };
        0x2::event::emit<MessageEvent>(v0);
    }

    public entry fun set_pay_to(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f || v0 == arg0.setter, 1);
        arg0.pay_to = arg1;
    }

    public entry fun set_setter(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f || v0 == arg0.setter, 1);
        arg0.setter = arg1;
    }

    public entry fun update_manage_config(arg0: &mut ManageConfig, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0xf3cf5493e58e308861e4c8649cdcb44a24c4f6ecce3db46ee9d99ba96daaca1f, 1);
        arg0.is_live = arg3;
        arg0.pay_to = arg1;
        arg0.fee = arg2;
    }

    public entry fun update_token_profile<T0>(arg0: &mut ManageConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fee <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 3);
        assert!(arg0.is_live, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.pay_to);
        let v0 = UpdateTokenProfileEvent{
            user        : 0x2::tx_context::sender(arg7),
            coin_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            web_site    : arg2,
            twitter     : arg3,
            telegram    : arg4,
            description : arg5,
            logo_image  : arg6,
        };
        0x2::event::emit<UpdateTokenProfileEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

