module 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::pool {
    struct DepositEvent has copy, drop {
        pool_id: address,
        input_coin_type: 0x1::type_name::TypeName,
        input_coin_decimals: u8,
        input_coin_amount: u64,
        obligation_id: address,
        currency_id: address,
        created_at: u64,
        sender: address,
        vault: address,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        version: u64,
        created_at: u64,
        treasury_address: address,
    }

    struct CreateObligationEvent has copy, drop {
        pool_id: address,
        obligation_id: 0x2::object::ID,
        created_at: u64,
        sender: address,
        card_program_id: 0x2::object::ID,
        card_program_name: 0x1::string::String,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        currencies: vector<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>,
        card_programs: vector<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::CardProgram<T0>>,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>,
        treasury_address: address,
    }

    struct PoolOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        eligible_pool_id: 0x2::object::ID,
    }

    struct ObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_id: 0x2::object::ID,
    }

    public fun currency<T0>(arg0: &Pool<T0>, arg1: u64) : &0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0> {
        0x1::vector::borrow<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(&arg0.currencies, arg1)
    }

    public(friend) fun obligation<T0>(arg0: &Pool<T0>, arg1: 0x2::object::ID) : &0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    public fun create_obligation<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap<T0> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x1::vector::borrow<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::CardProgram<T0>>(&arg0.card_programs, arg1);
        let v1 = 0x2::object::id<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::CardProgram<T0>>(v0);
        let v2 = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::create_obligation<T0>(0x2::object::id<Pool<T0>>(arg0), v1, arg2);
        let v3 = ObligationOwnerCap<T0>{
            id            : 0x2::object::new(arg2),
            obligation_id : 0x2::object::id<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>(&v2),
        };
        let v4 = 0x2::object::id<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>(&v2);
        0x2::object_table::add<0x2::object::ID, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>(&mut arg0.obligations, v4, v2);
        let v5 = CreateObligationEvent{
            pool_id           : 0x2::object::id_address<Pool<T0>>(arg0),
            obligation_id     : v4,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg2),
            sender            : 0x2::tx_context::sender(arg2),
            card_program_id   : v1,
            card_program_name : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::brand<T0>(v0),
        };
        0x2::event::emit<CreateObligationEvent>(v5);
        v3
    }

    public fun deposit<T0, T1>(arg0: &ObligationOwnerCap<T0>, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 2);
        let v1 = 0x1::vector::borrow_mut<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(&mut arg1.currencies, arg2);
        assert!(0x1::type_name::get<T1>() == 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::coin_type<T0>(v1), 3);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>(&mut arg1.obligations, arg0.obligation_id);
        0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::deposit<T0>(v2, v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg1.treasury_address);
        let v3 = DepositEvent{
            pool_id             : 0x2::object::id_address<Pool<T0>>(arg1),
            input_coin_type     : 0x1::type_name::get<T1>(),
            input_coin_decimals : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::decimals<T0>(v1),
            input_coin_amount   : v0,
            obligation_id       : 0x2::object::id_address<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>(v2),
            currency_id         : 0x2::object::id_address<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(v1),
            created_at          : 0x2::clock::timestamp_ms(arg4) / 1000,
            sender              : 0x2::tx_context::sender(arg5),
            vault               : arg1.treasury_address,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun add_card_program<T0>(arg0: &PoolOwnerCap<T0>, arg1: &mut Pool<T0>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::validate_inputs(arg4, arg5);
        0x1::vector::push_back<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::CardProgram<T0>>(&mut arg1.card_programs, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::create_card_program<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun add_card_program_v2<T0>(arg0: &PoolOwnerCap<T0>, arg1: &mut Pool<T0>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        add_card_program<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun add_currency<T0, T1>(arg0: &PoolOwnerCap<T0>, arg1: &mut Pool<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(get_currency_index<T0, T1>(arg1) == 0x1::vector::length<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(&arg1.currencies), 4);
        0x1::vector::push_back<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(&mut arg1.currencies, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::create_currency<T0, T1>(0x2::object::id<Pool<T0>>(arg1), (0x1::vector::length<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(&arg1.currencies) as u64), arg2, 0, 0x2::coin::get_decimals<T1>(arg3), arg4, arg5));
    }

    public fun card_programs<T0>(arg0: &Pool<T0>) : &vector<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::CardProgram<T0>> {
        &arg0.card_programs
    }

    entry fun create_obligation_and_deposit<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_obligation<T0>(arg0, arg1, arg4);
        let v1 = get_currency_index<T0, T1>(arg0);
        deposit<T0, T1>(&v0, arg0, v1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<ObligationOwnerCap<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun create_pool_internal<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (PoolOwnerCap<T0>, Pool<T0>) {
        let v0 = Pool<T0>{
            id               : 0x2::object::new(arg1),
            version          : 1,
            currencies       : 0x1::vector::empty<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(),
            card_programs    : 0x1::vector::empty<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program::CardProgram<T0>>(),
            obligations      : 0x2::object_table::new<0x2::object::ID, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation::Obligation<T0>>(arg1),
            treasury_address : arg0,
        };
        let v1 = PoolOwnerCap<T0>{
            id               : 0x2::object::new(arg1),
            eligible_pool_id : 0x2::object::id<Pool<T0>>(&v0),
        };
        let v2 = PoolCreatedEvent{
            pool_id          : 0x2::object::id_address<Pool<T0>>(&v0),
            version          : v0.version,
            created_at       : 0x2::tx_context::epoch_timestamp_ms(arg1),
            treasury_address : arg0,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        (v1, v0)
    }

    public fun currencies<T0>(arg0: &Pool<T0>) : &vector<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>> {
        &arg0.currencies
    }

    public fun get_currency_index<T0, T1>(arg0: &Pool<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>>(&arg0.currencies)) {
            if (0x1::type_name::get<T1>() == 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::coin_type<T0>(currency<T0>(arg0, v0))) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    entry fun migrate<T0>(arg0: &PoolOwnerCap<T0>, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version <= 1 - 1, 1);
        arg1.version = 1;
    }

    public fun obligation_id<T0>(arg0: &ObligationOwnerCap<T0>) : 0x2::object::ID {
        arg0.obligation_id
    }

    public fun set_treasury_address<T0>(arg0: &PoolOwnerCap<T0>, arg1: &mut Pool<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        arg1.treasury_address = arg2;
    }

    public fun treasury_address<T0>(arg0: &Pool<T0>) : address {
        arg0.treasury_address
    }

    // decompiled from Move bytecode v6
}

