module 0xcb82cac2fa54c620e9427a2cff07f3cd96b6b823f06ec4d57e9489d6987ba1fc::whitelist_module {
    struct WhiteListElement has copy, drop, store {
        wallet_address: address,
        limit: u64,
        bought: u64,
    }

    struct WhitelistContainer has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        owner: 0x2::object::ID,
        elements: vector<0x2::object::ID>,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        whitelist_elements: vector<WhiteListElement>,
    }

    struct AddWhitelistEvent has copy, drop {
        round_id: 0x2::object::ID,
        wallets: vector<address>,
        limits: vector<u64>,
        boughts: vector<u64>,
    }

    struct DeleteWhitelistEvent has copy, drop {
        round_id: 0x2::object::ID,
        wallet: address,
    }

    public fun add_whitelist(arg0: &mut WhitelistContainer, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Whitelist>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&arg0.elements, 0x1::vector::length<0x2::object::ID>(&arg0.elements) - 1));
            if (0x1::vector::length<WhiteListElement>(&v2.whitelist_elements) < 100) {
                let v3 = WhiteListElement{
                    wallet_address : *0x1::vector::borrow<address>(&arg1, v1),
                    limit          : *0x1::vector::borrow<u64>(&arg2, v1),
                    bought         : 0,
                };
                0x1::vector::push_back<WhiteListElement>(&mut v2.whitelist_elements, v3);
                continue
            };
            let v4 = 0x1::vector::empty<WhiteListElement>();
            let v5 = WhiteListElement{
                wallet_address : *0x1::vector::borrow<address>(&arg1, v1),
                limit          : *0x1::vector::borrow<u64>(&arg2, v1),
                bought         : 0,
            };
            0x1::vector::push_back<WhiteListElement>(&mut v4, v5);
            let v6 = Whitelist{
                id                 : 0x2::object::new(arg3),
                whitelist_elements : v4,
            };
            let v7 = 0x2::object::id<Whitelist>(&v6);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.elements, v7);
            0x2::dynamic_object_field::add<0x2::object::ID, Whitelist>(&mut arg0.id, v7, v6);
        };
        let v8 = AddWhitelistEvent{
            round_id : arg0.owner,
            wallets  : arg1,
            limits   : arg2,
            boughts  : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<AddWhitelistEvent>(v8);
    }

    public fun add_whitelist_with_bought(arg0: &mut WhitelistContainer, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2) || 0x1::vector::length<u64>(&arg3) == v0, 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<address>(&arg1, v1);
            let v3 = 0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = 0x1::vector::borrow<u64>(&arg3, v1);
            let v5 = existed(arg0, *v2);
            if (v5 == false) {
                let v6 = arg0.elements;
                let v7 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Whitelist>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v6, 0x1::vector::length<0x2::object::ID>(&v6) - 1));
                let v8 = v7.whitelist_elements;
                if (0x1::vector::length<WhiteListElement>(&v8) < 100) {
                    let v9 = WhiteListElement{
                        wallet_address : *v2,
                        limit          : *v3,
                        bought         : *v4,
                    };
                    0x1::vector::push_back<WhiteListElement>(&mut v7.whitelist_elements, v9);
                } else {
                    let v10 = 0x1::vector::empty<WhiteListElement>();
                    let v11 = WhiteListElement{
                        wallet_address : *v2,
                        limit          : *v3,
                        bought         : *v4,
                    };
                    0x1::vector::push_back<WhiteListElement>(&mut v10, v11);
                    let v12 = Whitelist{
                        id                 : 0x2::object::new(arg4),
                        whitelist_elements : v10,
                    };
                    let v13 = 0x2::object::id<Whitelist>(&v12);
                    0x1::vector::push_back<0x2::object::ID>(&mut arg0.elements, v13);
                    0x2::dynamic_object_field::add<0x2::object::ID, Whitelist>(&mut arg0.id, v13, v12);
                };
            };
            v1 = v1 + 1;
        };
        let v14 = AddWhitelistEvent{
            round_id : arg0.owner,
            wallets  : arg1,
            limits   : arg2,
            boughts  : arg3,
        };
        0x2::event::emit<AddWhitelistEvent>(v14);
    }

    public fun available_whitelist(arg0: &mut WhitelistContainer, arg1: u64, arg2: address, arg3: bool) : bool {
        let v0 = false;
        let v1 = false;
        let v2 = arg0.elements;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v4 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Whitelist>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v2, v3)).whitelist_elements;
            let v5 = 0;
            while (v5 < 0x1::vector::length<WhiteListElement>(&v4)) {
                let v6 = 0x1::vector::borrow<WhiteListElement>(&v4, v5);
                if (arg2 == v6.wallet_address) {
                    if (arg3 == true || v6.bought + arg1 <= v6.limit) {
                        v0 = true;
                    };
                    v1 = true;
                    break
                };
                v5 = v5 + 1;
            };
            if (v0 == true || v1 == true) {
                break
            };
            v3 = v3 + 1;
        };
        v0
    }

    public entry fun change_admin_addresses(arg0: &mut WhitelistContainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg2), 0);
        arg0.admin_address = arg1;
    }

    public fun create_whitelist_conatiner(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Whitelist{
            id                 : 0x2::object::new(arg1),
            whitelist_elements : 0x1::vector::empty<WhiteListElement>(),
        };
        let v1 = 0x2::object::id<Whitelist>(&v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, v1);
        let v3 = WhitelistContainer{
            id            : 0x2::object::new(arg1),
            admin_address : 0x2::tx_context::sender(arg1),
            owner         : arg0,
            elements      : v2,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Whitelist>(&mut v3.id, v1, v0);
        0x2::transfer::share_object<WhitelistContainer>(v3);
        0x2::object::id<WhitelistContainer>(&v3)
    }

    public fun delete_wallet_in_whitelist(arg0: &mut WhitelistContainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg2), 0);
        let v0 = existed(arg0, arg1);
        assert!(v0 == true, 2);
        let v1 = false;
        let v2 = arg0.elements;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v4 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Whitelist>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v2, v3));
            let v5 = v4.whitelist_elements;
            let v6 = 0;
            while (v6 < 0x1::vector::length<WhiteListElement>(&v5)) {
                if (arg1 == 0x1::vector::borrow<WhiteListElement>(&mut v5, v6).wallet_address) {
                    v1 = true;
                };
                v6 = v6 + 1;
            };
            if (v1 == true) {
                0x1::vector::remove<WhiteListElement>(&mut v4.whitelist_elements, 0);
                break
            };
            v3 = v3 + 1;
        };
        let v7 = DeleteWhitelistEvent{
            round_id : arg0.owner,
            wallet   : arg1,
        };
        0x2::event::emit<DeleteWhitelistEvent>(v7);
    }

    public fun existed(arg0: &mut WhitelistContainer, arg1: address) : bool {
        let v0 = false;
        let v1 = arg0.elements;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Whitelist>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v1, v2)).whitelist_elements;
            let v4 = 0;
            while (v4 < 0x1::vector::length<WhiteListElement>(&v3)) {
                if (arg1 == 0x1::vector::borrow<WhiteListElement>(&v3, v4).wallet_address) {
                    v0 = true;
                    break
                };
                v4 = v4 + 1;
            };
            if (v0 == true) {
                break
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_id(arg0: &mut WhitelistContainer) : 0x2::object::ID {
        0x2::object::id<WhitelistContainer>(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun update_whitelist(arg0: &mut WhitelistContainer, arg1: u64, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = available_whitelist(arg0, arg1, arg2, arg3);
        assert!(v0 == true, 3);
        let v1 = existed(arg0, arg2);
        assert!(v1 == true, 2);
        let v2 = false;
        let v3 = arg0.elements;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Whitelist>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v3, v4));
            let v6 = v5.whitelist_elements;
            let v7 = 0;
            while (v7 < 0x1::vector::length<WhiteListElement>(&v6)) {
                if (arg2 == 0x1::vector::borrow_mut<WhiteListElement>(&mut v6, v7).wallet_address) {
                    v2 = true;
                };
                v7 = v7 + 1;
            };
            if (v2 == true) {
                let v8 = 0x1::vector::remove<WhiteListElement>(&mut v5.whitelist_elements, 0);
                v8.bought = v8.bought + arg1;
                0x1::vector::push_back<WhiteListElement>(&mut v5.whitelist_elements, v8);
                break
            };
            v4 = v4 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

