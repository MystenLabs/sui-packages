module 0xda048b7600e5a22a0779ece52194fb872a223746781a683358e61da0c0b2a004::jujubeido {
    struct UserInfo has store {
        addr: address,
        amount: u128,
        claimed: bool,
    }

    struct JujubeIdoInfo has key {
        id: 0x2::object::UID,
        min_invest_amount: u64,
        start_time: u64,
        end_time: u64,
        distribution_time: u64,
        hardcap_amount: u64,
        total_offer_amount: u64,
        raise_pool: 0x2::coin::Coin<0x2::sui::SUI>,
        offer_pool: 0x2::coin::Coin<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>,
        raised_amount: u64,
    }

    public entry fun add_jujube_coin(arg0: 0x2::coin::Coin<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>, arg1: &mut JujubeIdoInfo, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 1001);
        assert!(0x2::coin::value<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>(&arg0) > 0, 1002);
        0x2::coin::join<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>(&mut arg1.offer_pool, arg0);
    }

    public entry fun claim_reward(arg0: &0x2::clock::Clock, arg1: &mut JujubeIdoInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.distribution_time != 0 && 0x2::clock::timestamp_ms(arg0) / 1000 >= arg1.distribution_time, 1003);
        assert!(0x2::dynamic_field::exists_<address>(&arg1.id, v0), 1005);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg1.id, v0);
        assert!(!v1.claimed, 1004);
        let v2 = v1.amount * (arg1.total_offer_amount as u128) / (arg1.hardcap_amount as u128);
        v1.claimed = true;
        if (v2 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>>(0x2::coin::split<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>(&mut arg1.offer_pool, (v2 as u64), arg2), v0);
        };
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 1001);
        let v0 = JujubeIdoInfo{
            id                 : 0x2::object::new(arg0),
            min_invest_amount  : 100000000,
            start_time         : 1683111600,
            end_time           : 1683716400,
            distribution_time  : 0,
            hardcap_amount     : 40000000000000,
            total_offer_amount : 2000000000000000,
            raise_pool         : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            offer_pool         : 0x2::coin::zero<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>(arg0),
            raised_amount      : 0,
        };
        0x2::transfer::share_object<JujubeIdoInfo>(v0);
    }

    public entry fun public_sale(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut JujubeIdoInfo, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 >= arg2.start_time && v0 <= arg2.end_time, 1003);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(arg2.hardcap_amount >= v2 + arg2.raised_amount, 1006);
        0x2::coin::join<0x2::sui::SUI>(&mut arg2.raise_pool, arg0);
        arg2.raised_amount = arg2.raised_amount + v2;
        if (0x2::dynamic_field::exists_<address>(&arg2.id, v1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg2.id, v1);
            v3.amount = v3.amount + (v2 as u128);
        } else {
            let v4 = UserInfo{
                addr    : v1,
                amount  : (v2 as u128),
                claimed : false,
            };
            0x2::dynamic_field::add<address, UserInfo>(&mut arg2.id, v1, v4);
        };
    }

    public entry fun set_all(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut JujubeIdoInfo, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 1001);
        arg6.start_time = arg0;
        arg6.end_time = arg1;
        arg6.total_offer_amount = arg2;
        arg6.hardcap_amount = arg3;
        arg6.min_invest_amount = arg4;
        arg6.distribution_time = arg5;
    }

    public entry fun take_amount(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: &mut JujubeIdoInfo, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 1001);
        assert!(0x2::clock::timestamp_ms(arg0) / 1000 >= arg3.end_time, 1003);
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg3.raise_pool, arg1, v0, arg4);
        0x2::pay::split_and_transfer<0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin::JUJUBE_COIN>(&mut arg3.offer_pool, arg2, v0, arg4);
    }

    // decompiled from Move bytecode v6
}

