module 0x27f071fa2d3003272c17101fc36439e9afe13dd382d1d16bcb0387e4c24598b2::escrow {
    struct ESCROW has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EscrowHub has key {
        id: 0x2::object::UID,
        version: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Escrow<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        status: u8,
        creator: address,
        creator_items_ids: vector<0x2::object::ID>,
        creator_coin_amount: u64,
        recipient: address,
        recipient_items_ids: vector<0x2::object::ID>,
        recipient_coin_amount: u64,
    }

    struct EscrowCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct EscrowCanceled has copy, drop {
        id: 0x2::object::ID,
    }

    struct EscrowExchanged has copy, drop {
        id: 0x2::object::ID,
    }

    fun add_coin_to_dof(arg0: &mut 0x2::object::UID, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x1::string::utf8(b"escrowed_coin"), arg1);
        0x2::coin::value<0x2::sui::SUI>(&arg1)
    }

    fun add_items_to_dof<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: vector<T0>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            let v1 = 0x1::vector::pop_back<T0>(&mut arg1);
            let v2 = 0x2::object::id<T0>(&v1);
            0x2::dynamic_object_field::add<0x2::object::ID, T0>(arg0, v2, v1);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v2);
        };
        0x1::vector::destroy_empty<T0>(arg1);
        v0
    }

    entry fun cancel<T0: store + key>(arg0: &mut EscrowHub, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        check_hub_version(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Escrow<T0>>(&mut arg0.id, arg1);
        assert!(v0.status == 1, 5);
        assert!(0x2::tx_context::sender(arg2) == v0.creator, 0);
        let v1 = EscrowCanceled{id: 0x2::object::id<Escrow<T0>>(v0)};
        0x2::event::emit<EscrowCanceled>(v1);
        v0.status = 0;
        let v2 = &mut v0.id;
        transfer_items<T0>(get_items_from_dof<T0>(v2, v0.creator_items_ids), 0x2::tx_context::sender(arg2));
        let v3 = &mut v0.id;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(get_coin_from_dof(v3), 0x2::tx_context::sender(arg2));
    }

    fun check_hub_version(arg0: &EscrowHub) {
        assert!(arg0.version == 0, 8);
    }

    fun check_items_ids<T0: store + key>(arg0: &vector<T0>, arg1: &vector<0x2::object::ID>) {
        assert!(0x1::vector::length<T0>(arg0) == 0x1::vector::length<0x2::object::ID>(arg1), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(arg0)) {
            let v1 = 0x2::object::id<T0>(0x1::vector::borrow<T0>(arg0, v0));
            assert!(0x1::vector::contains<0x2::object::ID>(arg1, &v1), 2);
            v0 = v0 + 1;
        };
    }

    fun check_vector_for_duplicates<T0: copy + drop>(arg0: &vector<T0>) {
        let v0 = 0x2::vec_set::empty<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(arg0)) {
            0x2::vec_set::insert<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, v1));
            v1 = v1 + 1;
        };
    }

    entry fun create<T0: store + key>(arg0: &mut EscrowHub, arg1: vector<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: vector<0x2::object::ID>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        check_hub_version(arg0);
        assert!(arg3 != 0x2::tx_context::sender(arg6), 1);
        assert!(0x1::vector::length<T0>(&arg1) > 0 || 0x1::vector::length<0x2::object::ID>(&arg4) > 0, 4);
        let v0 = 0x2::object::new(arg6);
        let v1 = &mut v0;
        let v2 = &mut v0;
        check_vector_for_duplicates<0x2::object::ID>(&arg4);
        let v3 = Escrow<T0>{
            id                    : v0,
            status                : 1,
            creator               : 0x2::tx_context::sender(arg6),
            creator_items_ids     : add_items_to_dof<T0>(v1, arg1),
            creator_coin_amount   : add_coin_to_dof(v2, arg2),
            recipient             : arg3,
            recipient_items_ids   : arg4,
            recipient_coin_amount : arg5,
        };
        let v4 = EscrowCreated{id: 0x2::object::id<Escrow<T0>>(&v3)};
        0x2::event::emit<EscrowCreated>(v4);
        0x2::dynamic_object_field::add<0x2::object::ID, Escrow<T0>>(&mut arg0.id, 0x2::object::id<Escrow<T0>>(&v3), v3);
    }

    entry fun exchange<T0: store + key>(arg0: &mut EscrowHub, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: vector<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        check_hub_version(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee, 6);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Escrow<T0>>(&mut arg0.id, arg2);
        assert!(v0.status == 1, 5);
        assert!(0x2::tx_context::sender(arg5) == v0.recipient, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v0.recipient_coin_amount, 3);
        check_items_ids<T0>(&arg3, &v0.recipient_items_ids);
        let v1 = EscrowExchanged{id: 0x2::object::id<Escrow<T0>>(v0)};
        0x2::event::emit<EscrowExchanged>(v1);
        v0.status = 2;
        let v2 = &mut v0.id;
        transfer_items<T0>(get_items_from_dof<T0>(v2, v0.creator_items_ids), 0x2::tx_context::sender(arg5));
        let v3 = &mut v0.id;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(get_coin_from_dof(v3), 0x2::tx_context::sender(arg5));
        transfer_items<T0>(arg3, v0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0.creator);
    }

    fun get_coin_from_dof(arg0: &mut 0x2::object::UID) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x1::string::utf8(b"escrowed_coin"))
    }

    fun get_items_from_dof<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: vector<0x2::object::ID>) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x1::vector::push_back<T0>(&mut v0, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
        v0
    }

    fun init(arg0: ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ESCROW>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = EscrowHub{
            id      : 0x2::object::new(arg1),
            version : 0,
            fee     : 400000000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<EscrowHub>(v1);
    }

    entry fun migrate_hub(arg0: &AdminCap, arg1: &mut EscrowHub) {
        assert!(arg1.version < 0, 9);
        arg1.version = 0;
    }

    fun transfer_items<T0: store + key>(arg0: vector<T0>, arg1: address) {
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    entry fun update_fee(arg0: &AdminCap, arg1: &mut EscrowHub, arg2: u64) {
        arg1.fee = arg2;
    }

    entry fun withdraw(arg0: &AdminCap, arg1: &mut EscrowHub, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 7);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

