module 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey {
    struct PackageVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Journey has key {
        id: 0x2::object::UID,
        treasury: address,
        price: u64,
        window_ms: u64,
    }

    struct Session has key {
        id: 0x2::object::UID,
        journey_id: 0x2::object::ID,
        buyer: address,
        expiry_ms: u64,
        blob_id: vector<u8>,
        completed: bool,
    }

    public fun blob_id(arg0: &Session) : vector<u8> {
        arg0.blob_id
    }

    public fun buyer(arg0: &Session) : address {
        arg0.buyer
    }

    fun check_policy(arg0: vector<u8>, arg1: &PackageVersion, arg2: &Session, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : bool {
        assert!(arg1.version == 1, 5);
        if (0x2::tx_context::sender(arg4) != arg2.buyer) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg3) >= arg2.expiry_ms) {
            return false
        };
        let v0 = 0x2::object::uid_to_bytes(&arg2.id);
        if (0x1::vector::length<u8>(&v0) > 0x1::vector::length<u8>(&arg0)) {
            return false
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) != *0x1::vector::borrow<u8>(&arg0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    entry fun complete(arg0: &mut Session, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.buyer, 20);
        assert!(!arg0.completed, 21);
        arg0.blob_id = arg1;
        arg0.completed = true;
    }

    entry fun create_journey(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Journey{
            id        : 0x2::object::new(arg4),
            treasury  : arg1,
            price     : arg2,
            window_ms : arg3,
        };
        0x2::transfer::share_object<Journey>(v0);
    }

    public fun expiry_ms(arg0: &Session) : u64 {
        arg0.expiry_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_completed(arg0: &Session) : bool {
        arg0.completed
    }

    entry fun purchase<T0>(arg0: &Journey, arg1: &mut 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg1) >= arg0.price, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg0.price, arg3), arg0.treasury);
        let v0 = Session{
            id         : 0x2::object::new(arg3),
            journey_id : 0x2::object::id<Journey>(arg0),
            buyer      : 0x2::tx_context::sender(arg3),
            expiry_ms  : 0x2::clock::timestamp_ms(arg2) + arg0.window_ms,
            blob_id    : b"",
            completed  : false,
        };
        0x2::transfer::share_object<Session>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PackageVersion, arg2: &Session, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg0, arg1, arg2, arg3, arg4), 77);
    }

    entry fun set_blob_id(arg0: &mut Session, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.buyer, 20);
        assert!(!arg0.completed, 21);
        arg0.blob_id = arg1;
    }

    // decompiled from Move bytecode v7
}

