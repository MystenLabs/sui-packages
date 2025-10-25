module 0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::bulk_transfer {
    struct Accounts has store, key {
        id: 0x2::object::UID,
        account: 0x2::linked_table::LinkedTable<address, u64>,
    }

    public fun bulk_transfer(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: &mut 0x2::coin::Coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>, arg2: &mut Accounts, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x2::linked_table::is_empty<address, u64>(&arg2.account)) {
            let (v0, v1) = 0x2::linked_table::pop_front<address, u64>(&mut arg2.account);
            0x2::pay::split_and_transfer<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>(arg1, v1, v0, arg3);
        };
    }

    public fun add_account(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: &mut Accounts, arg2: address, arg3: u64) {
        0x2::linked_table::push_back<address, u64>(&mut arg1.account, arg2, arg3);
    }

    public fun add_account_vecs(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: &mut Accounts, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        0x1::vector::reverse<address>(&mut arg2);
        0x1::vector::reverse<u64>(&mut arg3);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::linked_table::push_back<address, u64>(&mut arg1.account, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
        };
    }

    public fun add_accounts(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: &mut 0x2::tx_context::TxContext) : Accounts {
        Accounts{
            id      : 0x2::object::new(arg1),
            account : 0x2::linked_table::new<address, u64>(arg1),
        }
    }

    public fun drop_account(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: &mut Accounts) {
        while (!0x2::linked_table::is_empty<address, u64>(&arg1.account)) {
            let (v0, _) = 0x2::linked_table::pop_front<address, u64>(&mut arg1.account);
            0x2::linked_table::remove<address, u64>(&mut arg1.account, v0);
        };
    }

    public fun modify_account(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: &mut Accounts, arg2: address, arg3: u64) {
        *0x2::linked_table::borrow_mut<address, u64>(&mut arg1.account, arg2) = arg3;
    }

    public fun remove_account(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: &mut Accounts, arg2: address) {
        0x2::linked_table::remove<address, u64>(&mut arg1.account, arg2);
    }

    public fun remove_accounts(arg0: &0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::ControlledTreasuryCap, arg1: Accounts) {
        let Accounts {
            id      : v0,
            account : v1,
        } = arg1;
        0x2::linked_table::drop<address, u64>(v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

