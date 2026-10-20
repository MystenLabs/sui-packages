module 0x30692549928e784a93c25457e23ef925f61509e7b0f799afadeeb3c8275b304e::book {
    struct AbilityRegistry has key {
        id: 0x2::object::UID,
    }

    struct BookKey has copy, drop, store {
        pos0: address,
    }

    struct AbilityBook has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        charges: vector<u64>,
        total_bought: vector<u64>,
        total_used: vector<u64>,
    }

    struct AbilityBookCreated has copy, drop {
        book_id: 0x2::object::ID,
        owner: address,
    }

    struct AbilitiesEquipped has copy, drop {
        book_id: 0x2::object::ID,
        owner: address,
        kinds: vector<u8>,
        remaining: vector<u64>,
    }

    public(friend) fun assert_version(arg0: &AbilityBook) {
        assert!(arg0.version == 1, 13906835149301284870);
    }

    public fun book_address(arg0: 0x2::object::ID, arg1: address) : address {
        let v0 = BookKey{pos0: arg1};
        0x2::derived_object::derive_address<BookKey>(arg0, v0)
    }

    public fun book_exists(arg0: &AbilityRegistry, arg1: address) : bool {
        let v0 = BookKey{pos0: arg1};
        0x2::derived_object::exists<BookKey>(&arg0.id, v0)
    }

    public fun charges(arg0: &AbilityBook) : vector<u64> {
        arg0.charges
    }

    public fun charges_of(arg0: &AbilityBook, arg1: u8) : u64 {
        assert!(is_kind(arg1), 13906834947438477328);
        *0x1::vector::borrow<u64>(&arg0.charges, (arg1 as u64))
    }

    public fun create_book(arg0: &mut AbilityRegistry, arg1: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_book(arg0, arg1);
        share_book(v0);
        0x2::object::id<AbilityBook>(&v0)
    }

    public(friend) fun credit(arg0: &mut AbilityBook, arg1: u8, arg2: u64) : u64 {
        assert_version(arg0);
        let v0 = (arg1 as u64);
        let v1 = *0x1::vector::borrow<u64>(&arg0.charges, v0) + arg2;
        *0x1::vector::borrow_mut<u64>(&mut arg0.charges, v0) = v1;
        *0x1::vector::borrow_mut<u64>(&mut arg0.total_bought, v0) = *0x1::vector::borrow<u64>(&arg0.total_bought, v0) + arg2;
        v1
    }

    public fun equip(arg0: &mut AbilityBook, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 13906834754164686860);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 13906834758459785230);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        let v2 = &arg1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            let v4 = 0x1::vector::borrow<u8>(v2, v3);
            assert!(is_kind(*v4), 13906834771344818192);
            let v5 = (*v4 as u64);
            assert!(!*0x1::vector::borrow<bool>(&v0, v5), 13906834779934883858);
            *0x1::vector::borrow_mut<bool>(&mut v0, v5) = true;
            v3 = v3 + 1;
        };
        let v6 = &arg1;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(v6)) {
            assert!(*0x1::vector::borrow<u64>(&arg0.charges, (*0x1::vector::borrow<u8>(v6, v7) as u64)) > 0, 13906834792819916820);
            v7 = v7 + 1;
        };
        let v8 = &arg1;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u8>(v8)) {
            let v10 = (*0x1::vector::borrow<u8>(v8, v9) as u64);
            *0x1::vector::borrow_mut<u64>(&mut arg0.charges, v10) = *0x1::vector::borrow<u64>(&arg0.charges, v10) - 1;
            *0x1::vector::borrow_mut<u64>(&mut arg0.total_used, v10) = *0x1::vector::borrow<u64>(&arg0.total_used, v10) + 1;
            v9 = v9 + 1;
        };
        let v11 = AbilitiesEquipped{
            book_id   : 0x2::object::id<AbilityBook>(arg0),
            owner     : arg0.owner,
            kinds     : arg1,
            remaining : arg0.charges,
        };
        0x2::event::emit<AbilitiesEquipped>(v11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AbilityRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AbilityRegistry>(v0);
    }

    public fun is_kind(arg0: u8) : bool {
        (arg0 as u64) < 3
    }

    public fun kind_count() : u64 {
        3
    }

    public fun kind_fly() : u8 {
        0
    }

    public fun kind_freeze() : u8 {
        2
    }

    public fun kind_magnet() : u8 {
        1
    }

    public fun migrate(arg0: &mut AbilityBook) {
        assert!(arg0.version < 1, 13906834883013443592);
        arg0.version = 1;
    }

    public fun new_book(arg0: &mut AbilityRegistry, arg1: &0x2::tx_context::TxContext) : AbilityBook {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = BookKey{pos0: v0};
        assert!(!0x2::derived_object::exists<BookKey>(&arg0.id, v1), 13906834603840700426);
        let v2 = BookKey{pos0: v0};
        let v3 = AbilityBook{
            id           : 0x2::derived_object::claim<BookKey>(&mut arg0.id, v2),
            version      : 1,
            owner        : v0,
            charges      : zeros(),
            total_bought : zeros(),
            total_used   : zeros(),
        };
        let v4 = AbilityBookCreated{
            book_id : 0x2::object::id<AbilityBook>(&v3),
            owner   : v0,
        };
        0x2::event::emit<AbilityBookCreated>(v4);
        v3
    }

    public fun owner(arg0: &AbilityBook) : address {
        arg0.owner
    }

    public fun package_version() : u64 {
        1
    }

    public(friend) fun registry_uid_mut(arg0: &mut AbilityRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun share_book(arg0: AbilityBook) {
        0x2::transfer::share_object<AbilityBook>(arg0);
    }

    public fun total_bought(arg0: &AbilityBook) : vector<u64> {
        arg0.total_bought
    }

    public fun total_used(arg0: &AbilityBook) : vector<u64> {
        arg0.total_used
    }

    public fun version(arg0: &AbilityBook) : u64 {
        arg0.version
    }

    fun zeros() : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

