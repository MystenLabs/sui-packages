module 0xebe9252d0a217c88ce5866d628bd77c4a5cb03173da6f674db8609b0ad0a4adc::network_config {
    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
        deployer: address,
    }

    struct InitEvent has copy, drop {
        deployer: address,
        admin: address,
    }

    struct AdminAddedEvent has copy, drop {
        admin: address,
    }

    struct AdminRemovedEvent has copy, drop {
        admin: address,
    }

    struct SuiTransferredEvent has copy, drop {
        admin: address,
        amount: u64,
        deployer: address,
    }

    public entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        let v1 = AdminAddedEvent{admin: arg1};
        0x2::event::emit<AdminAddedEvent>(v1);
    }

    public entry fun exchange_points(arg0: &AdminRegistry, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 1);
        assert!(arg2 > 0, 3);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg1)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 >= arg2, 2);
        let v3 = if (v2 == arg2) {
            v1
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
            0x2::coin::split<0x2::sui::SUI>(&mut v1, arg2, arg3)
        };
        let v4 = arg0.deployer;
        let v5 = SuiTransferredEvent{
            admin    : v0,
            amount   : arg2,
            deployer : v4,
        };
        0x2::event::emit<SuiTransferredEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v4);
    }

    public fun get_admin_count(arg0: &AdminRegistry) : u64 {
        0x2::vec_set::size<address>(&arg0.admins)
    }

    public fun get_deployer(arg0: &AdminRegistry) : address {
        arg0.deployer
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = AdminRegistry{
            id       : 0x2::object::new(arg0),
            admins   : v1,
            deployer : v0,
        };
        0x2::transfer::share_object<AdminRegistry>(v2);
        let v3 = InitEvent{
            deployer : v0,
            admin    : v0,
        };
        0x2::event::emit<InitEvent>(v3);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun remove_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
        let v1 = AdminRemovedEvent{admin: arg1};
        0x2::event::emit<AdminRemovedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

