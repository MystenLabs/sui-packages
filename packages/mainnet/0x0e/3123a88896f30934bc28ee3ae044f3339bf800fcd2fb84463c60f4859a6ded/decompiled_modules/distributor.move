module 0xe3123a88896f30934bc28ee3ae044f3339bf800fcd2fb84463c60f4859a6ded::distributor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Receipt has drop, store {
        prl_amount: u64,
        ostr_amount: u64,
        is_claimed: bool,
    }

    struct State has key {
        id: 0x2::object::UID,
        pearl_minter: 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>,
        ostr_minter: 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>,
        receipts: 0x2::table::Table<address, Receipt>,
        total_pearl_distributed: u64,
        total_ostr_distributed: u64,
    }

    public fun borrow_ostr_minter_id(arg0: &State) : &0x2::object::ID {
        0x2::object::borrow_id<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>>(&arg0.ostr_minter)
    }

    public fun borrow_pearl_minter_id(arg0: &State) : &0x2::object::ID {
        0x2::object::borrow_id<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>>(&arg0.pearl_minter)
    }

    entry fun claim(arg0: &mut State, arg1: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg2: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg3: &mut 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::TreasuryManagement, arg4: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, Receipt>(&arg0.receipts, v0), 1);
        assert!(!0x2::table::borrow<address, Receipt>(&arg0.receipts, v0).is_claimed, 2);
        set_is_claimed(arg0, v0);
        0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::mint_and_transfer(arg3, arg4, &arg0.pearl_minter, v0, 0x2::table::borrow<address, Receipt>(&arg0.receipts, v0).prl_amount, arg5);
        0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr::mint(arg1, arg2, &arg0.ostr_minter, v0, 0x2::table::borrow<address, Receipt>(&arg0.receipts, v0).ostr_amount);
    }

    entry fun distribute(arg0: &AdminCap, arg1: &mut State, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>) {
        distribute_internal(arg1, arg2, arg3, arg4);
    }

    fun distribute_internal(arg0: &mut State, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg2, v0);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v0);
            if (0x2::table::contains<address, Receipt>(&arg0.receipts, v1)) {
                let v4 = 0x2::table::borrow_mut<address, Receipt>(&mut arg0.receipts, v1);
                assert!(!v4.is_claimed, 2);
                arg0.total_pearl_distributed = arg0.total_pearl_distributed - v4.prl_amount;
                arg0.total_ostr_distributed = arg0.total_ostr_distributed - v4.ostr_amount;
                v4.prl_amount = v2;
                v4.ostr_amount = v3;
            } else {
                let v5 = Receipt{
                    prl_amount  : v2,
                    ostr_amount : v3,
                    is_claimed  : false,
                };
                0x2::table::add<address, Receipt>(&mut arg0.receipts, v1, v5);
            };
            assert!(v2 <= 50000000000000 - arg0.total_pearl_distributed, 3);
            assert!(v3 <= 450000000000000 - arg0.total_ostr_distributed, 3);
            arg0.total_pearl_distributed = arg0.total_pearl_distributed + v2;
            arg0.total_ostr_distributed = arg0.total_ostr_distributed + v3;
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = State{
            id                      : 0x2::object::new(arg0),
            pearl_minter            : 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>(arg0),
            ostr_minter             : 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>(arg0),
            receipts                : 0x2::table::new<address, Receipt>(arg0),
            total_pearl_distributed : 0,
            total_ostr_distributed  : 0,
        };
        0x2::transfer::share_object<State>(v1);
    }

    public fun is_claimed(arg0: &State, arg1: address) : bool {
        0x2::table::borrow<address, Receipt>(&arg0.receipts, arg1).is_claimed
    }

    public fun ostr_distributed_of(arg0: &State, arg1: address) : u64 {
        0x2::table::borrow<address, Receipt>(&arg0.receipts, arg1).ostr_amount
    }

    public fun pearl_distributed_of(arg0: &State, arg1: address) : u64 {
        0x2::table::borrow<address, Receipt>(&arg0.receipts, arg1).prl_amount
    }

    fun set_is_claimed(arg0: &mut State, arg1: address) {
        0x2::table::borrow_mut<address, Receipt>(&mut arg0.receipts, arg1).is_claimed = true;
    }

    public fun total_ostr_distributed(arg0: &State) : u64 {
        arg0.total_ostr_distributed
    }

    public fun total_pearl_distributed(arg0: &State) : u64 {
        arg0.total_pearl_distributed
    }

    // decompiled from Move bytecode v6
}

