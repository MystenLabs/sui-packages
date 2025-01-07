module 0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::locker {
    struct LockerContentsCreated has copy, drop {
        key_hash: vector<u8>,
        lockerContents_id: 0x2::object::ID,
        creator: address,
        unlocker: 0x1::option::Option<address>,
        tx_sender: address,
    }

    struct LockerContentsDeleted has copy, drop {
        key_hash: vector<u8>,
        lockerContents_id: 0x2::object::ID,
        creator: address,
        unlocker: 0x1::option::Option<address>,
        tx_sender: address,
    }

    struct LockerContentsUnlocked has copy, drop {
        key: vector<u8>,
        key_hash: vector<u8>,
        lockerContents_id: 0x2::object::ID,
        creator: address,
        unlocker: 0x1::option::Option<address>,
        tx_sender: address,
    }

    struct AddCoin has copy, drop {
        key_hash: vector<u8>,
        lockerContents_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        balance: u64,
        sender: address,
    }

    struct AddObject has copy, drop {
        key_hash: vector<u8>,
        lockerContents_id: 0x2::object::ID,
        object_type: 0x1::ascii::String,
        sender: address,
    }

    struct RemoveCoin has copy, drop {
        key_hash: vector<u8>,
        lockerContents_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        balance: u64,
        sender: address,
    }

    struct RemoveObject has copy, drop {
        key_hash: vector<u8>,
        lockerContents_id: 0x2::object::ID,
        object_type: 0x1::ascii::String,
        sender: address,
    }

    struct Locker has key {
        id: 0x2::object::UID,
    }

    struct LockerContents has store, key {
        id: 0x2::object::UID,
        bag: 0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::ObjectBag,
        creator: address,
        unlocker: 0x1::option::Option<address>,
    }

    public fun add_coin<T0>(arg0: &mut Locker, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, LockerContents>(&mut arg0.id, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 8);
        let v1 = AddCoin{
            key_hash          : arg1,
            lockerContents_id : 0x2::object::id<LockerContents>(v0),
            coin_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            balance           : 0x2::coin::value<T0>(&arg2),
            sender            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddCoin>(v1);
        0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::add<0x2::coin::Coin<T0>>(&mut v0.bag, 0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::length(&v0.bag), arg2);
    }

    public fun add_object<T0: store + key>(arg0: &mut Locker, arg1: vector<u8>, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(is_not_coin<T0>(), 7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, LockerContents>(&mut arg0.id, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 8);
        let v1 = AddObject{
            key_hash          : arg1,
            lockerContents_id : 0x2::object::id<LockerContents>(v0),
            object_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sender            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddObject>(v1);
        0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::add<T0>(&mut v0.bag, 0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::length(&v0.bag), arg2);
    }

    fun create_locker(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Locker{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Locker>(v0);
    }

    public fun create_locker_contents(arg0: &mut Locker, arg1: address, arg2: 0x1::option::Option<address>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LockerContents{
            id       : 0x2::object::new(arg4),
            bag      : 0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::new(arg4),
            creator  : arg1,
            unlocker : arg2,
        };
        let v1 = LockerContentsCreated{
            key_hash          : arg3,
            lockerContents_id : 0x2::object::id<LockerContents>(&v0),
            creator           : arg1,
            unlocker          : arg2,
            tx_sender         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LockerContentsCreated>(v1);
        0x2::dynamic_object_field::add<vector<u8>, LockerContents>(&mut arg0.id, arg3, v0);
    }

    public fun delete_locker_contents(arg0: &mut Locker, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let LockerContents {
            id       : v0,
            bag      : v1,
            creator  : v2,
            unlocker : v3,
        } = 0x2::dynamic_object_field::remove<vector<u8>, LockerContents>(&mut arg0.id, arg1);
        let v4 = v3;
        let v5 = v0;
        assert!(v2 == 0x2::tx_context::sender(arg2) || *0x1::option::borrow<address>(&v4) == 0x2::tx_context::sender(arg2), 8);
        let v6 = LockerContentsDeleted{
            key_hash          : arg1,
            lockerContents_id : 0x2::object::uid_to_inner(&v5),
            creator           : v2,
            unlocker          : v4,
            tx_sender         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<LockerContentsDeleted>(v6);
        0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::destroy_empty(v1);
        0x2::object::delete(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_locker(arg0);
    }

    fun is_not_coin<T0>() : bool {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x1::string::utf8(b"");
        if (0x1::string::length(&v0) > 76) {
            v1 = 0x1::string::sub_string(&v0, 0, 76);
        };
        !(v1 == 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::coin::Coin"))
    }

    public fun lock_exists(arg0: &Locker, arg1: vector<u8>) : bool {
        0x2::dynamic_object_field::exists_with_type<vector<u8>, LockerContents>(&arg0.id, arg1)
    }

    public fun remove_coin<T0>(arg0: &mut Locker, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, LockerContents>(&mut arg0.id, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3) || *0x1::option::borrow<address>(&v0.unlocker) == 0x2::tx_context::sender(arg3), 8);
        let v1 = 0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::remove<0x2::coin::Coin<T0>>(&mut v0.bag, arg2);
        let v2 = RemoveCoin{
            key_hash          : arg1,
            lockerContents_id : 0x2::object::id<LockerContents>(v0),
            coin_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            balance           : 0x2::coin::value<T0>(&v1),
            sender            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RemoveCoin>(v2);
        v1
    }

    public fun remove_coin_to<T0>(arg0: &mut Locker, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(remove_coin<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun remove_object<T0: store + key>(arg0: &mut Locker, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(is_not_coin<T0>(), 7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, LockerContents>(&mut arg0.id, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3) || *0x1::option::borrow<address>(&v0.unlocker) == 0x2::tx_context::sender(arg3), 8);
        let v1 = RemoveObject{
            key_hash          : arg1,
            lockerContents_id : 0x2::object::id<LockerContents>(v0),
            object_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sender            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RemoveObject>(v1);
        0x919ef54b31fe5ccc8cf986584017b862bc44df5c9d6ec0aaee570285afb92102::object_bag::remove<T0>(&mut v0.bag, arg2)
    }

    public fun remove_object_to<T0: store + key>(arg0: &mut Locker, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(remove_object<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun unlock(arg0: &mut Locker, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::hash::sha3_256(arg1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, LockerContents>(&mut arg0.id, v0);
        v1.unlocker = arg2;
        let v2 = LockerContentsUnlocked{
            key               : arg1,
            key_hash          : v0,
            lockerContents_id : 0x2::object::id<LockerContents>(v1),
            creator           : v1.creator,
            unlocker          : arg2,
            tx_sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LockerContentsUnlocked>(v2);
    }

    // decompiled from Move bytecode v6
}

