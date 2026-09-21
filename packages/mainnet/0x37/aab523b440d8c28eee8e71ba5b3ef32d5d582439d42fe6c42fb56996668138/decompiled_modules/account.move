module 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account {
    struct Account has key {
        id: 0x2::object::UID,
        info: AccountInfo,
        positions: 0x2::bag::Bag,
    }

    struct AccountInfo has copy, drop, store {
        tag: vector<u8>,
        owner: address,
        recipient: address,
        slot: vector<u8>,
    }

    struct Receipt<phantom T0> {
        lender_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        repay_amount: u64,
    }

    public fun account_id(arg0: &Account) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun account_owner(arg0: &AccountInfo) : address {
        arg0.owner
    }

    public fun account_recipient(arg0: &AccountInfo) : address {
        arg0.recipient
    }

    public fun account_slot(arg0: &AccountInfo) : vector<u8> {
        arg0.slot
    }

    public fun account_tag(arg0: &AccountInfo) : vector<u8> {
        arg0.tag
    }

    public fun add_position<T0: store + key>(arg0: &mut Account, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        check_account_owner(arg0, arg2);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.positions, 0x2::object::id<T0>(&arg1), arg1);
    }

    fun check_account<T0>(arg0: &Account, arg1: &0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: &0x2::tx_context::TxContext) {
        check_account_owner(arg0, arg2);
        check_account_vault<T0>(arg0, arg1);
    }

    fun check_account_owner(arg0: &Account, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.info.owner == 0x2::tx_context::sender(arg1), 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::invalid_sender());
    }

    fun check_account_vault<T0>(arg0: &Account, arg1: &0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>) {
        let v0 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::vault_traders<T0>(arg1);
        let v1 = account_id(arg0);
        assert!(0x1::vector::contains<address>(&v0, &v1), 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::invalid_trader());
    }

    public(friend) fun create(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Account {
        Account{
            id        : 0x2::object::new(arg1),
            info      : get_account_info(arg0),
            positions : 0x2::bag::new(arg1),
        }
    }

    fun get_account_info(arg0: vector<u8>) : AccountInfo {
        let v0 = 0x2::bcs::new(arg0);
        AccountInfo{
            tag       : 0x2::bcs::peel_vec_u8(&mut v0),
            owner     : 0x2::bcs::peel_address(&mut v0),
            recipient : 0x2::bcs::peel_address(&mut v0),
            slot      : 0x2::bcs::peel_vec_u8(&mut v0),
        }
    }

    public(friend) fun get_info(arg0: &Account) : AccountInfo {
        arg0.info
    }

    public fun lend_coins<T0>(arg0: &Account, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        check_account<T0>(arg0, arg1, arg3);
        let v0 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::withdraw<T0>(arg1, arg2, arg3);
        let v1 = Receipt<T0>{
            lender_id    : 0x2::object::id<Account>(arg0),
            vault_id     : 0x2::object::id<0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>>(arg1),
            repay_amount : 0x2::coin::value<T0>(&v0),
        };
        (v0, v1)
    }

    public(friend) fun modify_owner(arg0: &mut Account, arg1: address) {
        arg0.info.owner = arg1;
    }

    public(friend) fun modify_recipient(arg0: &mut Account, arg1: address) {
        arg0.info.recipient = arg1;
    }

    public(friend) fun modify_slot(arg0: &mut Account, arg1: vector<u8>) {
        arg0.info.slot = arg1;
    }

    public(friend) fun modify_tag(arg0: &mut Account, arg1: vector<u8>) {
        arg0.info.tag = arg1;
    }

    public fun repay_coins<T0>(arg0: &Account, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: Receipt<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_account<T0>(arg0, arg1, arg4);
        let Receipt {
            lender_id    : v0,
            vault_id     : v1,
            repay_amount : v2,
        } = arg3;
        assert!(0x2::object::id<Account>(arg0) == v0, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::repay_to_wrong_lender());
        assert!(0x2::object::id<0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>>(arg1) == v1, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::repay_to_wrong_vault());
        assert!(0x2::coin::value<T0>(&arg2) >= v2, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::invalid_repayment_amount());
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, v2, arg4));
        arg2
    }

    public(friend) fun share_account(arg0: Account) {
        0x2::transfer::share_object<Account>(arg0);
    }

    public fun take_position<T0: store + key>(arg0: &mut Account, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        check_account_owner(arg0, arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.positions, arg1), 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error::position_not_found());
        0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.positions, arg1)
    }

    public fun withdraw_coins<T0>(arg0: &Account, arg1: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_account<T0>(arg0, arg1, arg3);
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::withdraw<T0>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

