module 0x305d343deb6c57ea79fa786f3b8e8eb687267d438800d830ca03eb2aede55094::xrc {
    struct XRC has drop {
        dummy_field: bool,
    }

    struct XRCTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<XRC>,
    }

    struct Lottery has key {
        id: 0x2::object::UID,
        nonce: u64,
        sale_price: u64,
        min_mint_amount: u64,
        beforehand_buyers: vector<address>,
        beforehand_buyer_threshold: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_addr: address,
    }

    struct LockedBonus has key {
        id: 0x2::object::UID,
        bonus_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        user_lottery_balance: 0x2::table::Table<address, u64>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AllowanceEvent has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct MintedEvent has copy, drop {
        user: address,
        amount: u64,
        cost: u64,
        timestamp: u64,
    }

    struct ClaimEvent has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    struct AdminWithDrawEvent has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    struct TransferAdminCapEvent has copy, drop {
        orginal_admin: address,
        to: address,
        timestamp: u64,
    }

    struct UpdateSalePriceEvent has copy, drop {
        orignal_sale_price: u64,
        present_sale_price: u64,
        timestamp: u64,
    }

    struct Output has copy, drop {
        addr: address,
        res: bool,
        byte1: vector<u8>,
        byte2: vector<u8>,
    }

    fun bcs_params(arg0: address, arg1: u64, arg2: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg2));
        v0
    }

    public entry fun claim(arg0: &mut LockedBonus, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg0.user_lottery_balance, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_lottery_balance, v0);
        assert!(*v1 >= arg2, 5);
        *v1 = *v1 - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.bonus_balance, arg2, arg4), arg1);
        let v2 = ClaimEvent{
            sender    : v0,
            recipient : arg1,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ClaimEvent>(v2);
    }

    public entry fun ecrecover_to_address(arg0: vector<u8>, arg1: vector<u8>) : address {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 1;
        while (v4 < 65) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::hash::keccak256(&v3);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 0;
        while (v7 < 32) {
            if (v7 < 12) {
                0x1::vector::push_back<u8>(&mut v6, 0);
            } else {
                0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            };
            v7 = v7 + 1;
        };
        0x2::address::from_bytes(v6)
    }

    fun get_random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg2)));
        0x1::vector::append<u8>(&mut v0, u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 2988507)));
        0x1::vector::append<u8>(&mut v0, u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 88319)));
        0x1::vector::append<u8>(&mut v0, u64_to_ascii(0x2::clock::timestamp_ms(arg1)));
        0x1::vector::append<u8>(&mut v0, *0x2::tx_context::digest(arg2));
        let v1 = 0x2::bcs::new(0x2::hash::blake2b256(&v0));
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        0x1::debug::print<u64>(&v2);
        v2
    }

    fun init(arg0: XRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRC>(arg0, 9, b"XRC", b"XRC", b"XRC Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRC>>(v1);
        let v2 = XRCTreasury{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<XRCTreasury>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Lottery{
            id                         : 0x2::object::new(arg1),
            nonce                      : 0,
            sale_price                 : 1000000,
            min_mint_amount            : 1000,
            beforehand_buyers          : 0x1::vector::empty<address>(),
            beforehand_buyer_threshold : 100,
            balance                    : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_addr                 : @0x18b59713afbf92e2321f6706c01ad63d4fb2fa6a,
        };
        0x2::transfer::share_object<Lottery>(v4);
        let v5 = LockedBonus{
            id                   : 0x2::object::new(arg1),
            bonus_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            user_lottery_balance : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<LockedBonus>(v5);
    }

    public entry fun mint(arg0: &mut Lottery, arg1: &mut LockedBonus, arg2: &mut XRCTreasury, arg3: address, arg4: u64, arg5: u256, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u8>, arg8: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        verify_signature(arg7, bcs_params(arg3, arg4, arg5), arg0.admin_addr);
        let v0 = arg0.sale_price * arg4;
        assert!(arg4 >= arg0.min_mint_amount, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg6) >= v0, 2);
        assert!(0x2::coin::total_supply<XRC>(&arg2.treasury_cap) + arg4 <= 100000000000, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg6, v0, arg10)));
        if (0x1::vector::length<address>(&arg0.beforehand_buyers) <= arg0.beforehand_buyer_threshold) {
            0x1::vector::push_back<address>(&mut arg0.beforehand_buyers, arg3);
        } else {
            let v1 = select_random_elements(&arg0.beforehand_buyers, get_random(arg8, arg9, arg10));
            let v2 = 0;
            let v3 = (((v0 as u256) * 10000 / 2 / 10000) as u64);
            let v4 = 0x1::vector::length<address>(&v1);
            while (v2 < v4) {
                let v5 = *0x1::vector::borrow<address>(&v1, v2);
                let v6 = v3 / v4;
                v3 = v3 - v6;
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.bonus_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v6));
                if (0x2::table::contains<address, u64>(&arg1.user_lottery_balance, v5)) {
                    let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg1.user_lottery_balance, v5);
                    *v7 = *v7 + v6;
                } else {
                    0x2::table::add<address, u64>(&mut arg1.user_lottery_balance, v5, v6);
                };
                v2 = v2 + 1;
                let v8 = AllowanceEvent{
                    user      : v5,
                    amount    : v6,
                    timestamp : 0x2::clock::timestamp_ms(arg9),
                };
                0x2::event::emit<AllowanceEvent>(v8);
            };
        };
        0x2::coin::mint_and_transfer<XRC>(&mut arg2.treasury_cap, arg4, arg3, arg10);
        let v9 = MintedEvent{
            user      : arg3,
            amount    : arg4,
            cost      : v0,
            timestamp : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<MintedEvent>(v9);
    }

    fun select_random_elements(arg0: &vector<address>, arg1: u64) : vector<address> {
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<u64>(&mut v1, v3);
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < arg1 % 50 + 100) {
            0x1::vector::swap<u64>(&mut v1, (arg1 + v4) % v0, (arg1 - v4 + v0) % v0);
            v4 = v4 + 1;
        };
        let v5 = 0;
        while (v5 < 5) {
            0x1::vector::push_back<address>(&mut v2, *0x1::vector::borrow<address>(arg0, *0x1::vector::borrow<u64>(&v1, v5)));
            v5 = v5 + 1;
        };
        v2
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = TransferAdminCapEvent{
            orginal_admin : 0x2::tx_context::sender(arg3),
            to            : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TransferAdminCapEvent>(v0);
    }

    fun u32_to_ascii(arg0: u32) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut Lottery, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1000000, 7);
        arg1.sale_price = arg2;
        let v0 = UpdateSalePriceEvent{
            orignal_sale_price : arg1.sale_price,
            present_sale_price : arg2,
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateSalePriceEvent>(v0);
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: address) {
        assert!(ecrecover_to_address(arg0, arg1) == arg2, 6);
    }

    public entry fun with_draw(arg0: &AdminCap, arg1: &mut Lottery, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg4), arg2);
        let v1 = AdminWithDrawEvent{
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminWithDrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

