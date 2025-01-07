module 0x41e1771682029b727adeded87f54be24e86b96fb122290be88fd41135644fac6::account {
    struct System has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, address>,
        accolades: 0x2::table::Table<address, 0x2::table_vec::TableVec<Accolade>>,
        reputation: 0x2::table::Table<address, 0x2::table_vec::TableVec<Reputation>>,
    }

    struct Accolade has drop, store {
        type: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct Reputation has drop, store {
        type: 0x1::string::String,
        value: u64,
        positive: bool,
        description: 0x1::string::String,
        url: 0x1::string::String,
        issuer: address,
    }

    struct Account has key {
        id: 0x2::object::UID,
        alias: 0x1::string::String,
        username: 0x1::string::String,
        creation_date: u64,
    }

    public fun new(arg0: &mut System, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Account {
        assert_no_avatar(arg0, 0x2::tx_context::sender(arg4));
        let v0 = Account{
            id            : 0x2::object::new(arg4),
            alias         : arg1,
            username      : arg2,
            creation_date : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<address, address>(&mut arg0.accounts, 0x2::tx_context::sender(arg4), 0x2::object::uid_to_address(&v0.id));
        v0
    }

    public fun add_accolade(arg0: &mut System, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_accolades_role(arg1, arg2);
        let v0 = Accolade{
            type        : arg4,
            description : arg5,
            url         : arg6,
        };
        if (!0x2::table::contains<address, 0x2::table_vec::TableVec<Accolade>>(&arg0.accolades, arg3)) {
            0x2::table::add<address, 0x2::table_vec::TableVec<Accolade>>(&mut arg0.accolades, arg3, 0x2::table_vec::empty<Accolade>(arg7));
        };
        0x2::table_vec::push_back<Accolade>(0x2::table::borrow_mut<address, 0x2::table_vec::TableVec<Accolade>>(&mut arg0.accolades, arg3), v0);
    }

    public fun alias(arg0: &Account) : 0x1::string::String {
        arg0.alias
    }

    public fun assert_no_avatar(arg0: &System, arg1: address) {
        assert!(!0x2::table::contains<address, address>(&arg0.accounts, arg1), 0);
    }

    public fun creation_date(arg0: &Account) : u64 {
        arg0.creation_date
    }

    public fun give_reputation(arg0: &mut System, arg1: &Account, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Reputation{
            type        : arg3,
            value       : arg4,
            positive    : arg5,
            description : arg6,
            url         : arg7,
            issuer      : 0x2::object::uid_to_address(&arg1.id),
        };
        if (!0x2::table::contains<address, 0x2::table_vec::TableVec<Reputation>>(&arg0.reputation, arg2)) {
            0x2::table::add<address, 0x2::table_vec::TableVec<Reputation>>(&mut arg0.reputation, arg2, 0x2::table_vec::empty<Reputation>(arg8));
        };
        0x2::table_vec::push_back<Reputation>(0x2::table::borrow_mut<address, 0x2::table_vec::TableVec<Reputation>>(&mut arg0.reputation, arg2), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = System{
            id         : 0x2::object::new(arg0),
            accounts   : 0x2::table::new<address, address>(arg0),
            accolades  : 0x2::table::new<address, 0x2::table_vec::TableVec<Accolade>>(arg0),
            reputation : 0x2::table::new<address, 0x2::table_vec::TableVec<Reputation>>(arg0),
        };
        0x2::transfer::share_object<System>(v0);
    }

    public fun keep(arg0: Account, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Account>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun remove_accolade(arg0: &mut System, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: address, arg4: u64) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_accolades_role(arg1, arg2);
        0x2::table_vec::swap_remove<Accolade>(0x2::table::borrow_mut<address, 0x2::table_vec::TableVec<Accolade>>(&mut arg0.accolades, arg3), arg4);
    }

    public fun remove_reputation(arg0: &mut System, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: address, arg4: u64) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_reputation_role(arg1, arg2);
        0x2::table_vec::swap_remove<Reputation>(0x2::table::borrow_mut<address, 0x2::table_vec::TableVec<Reputation>>(&mut arg0.reputation, arg3), arg4);
    }

    public fun update_alias(arg0: &mut Account, arg1: 0x1::string::String) {
        arg0.alias = arg1;
    }

    public fun update_username(arg0: &mut Account, arg1: 0x1::string::String) {
        arg0.username = arg1;
    }

    public fun username(arg0: &Account) : 0x1::string::String {
        arg0.username
    }

    // decompiled from Move bytecode v6
}

