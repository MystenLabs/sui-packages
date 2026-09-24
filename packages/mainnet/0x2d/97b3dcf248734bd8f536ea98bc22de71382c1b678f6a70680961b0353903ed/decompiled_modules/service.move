module 0x1e56d54bc3673729815a90e251bc54859901b55660ef7a4710641068238d6f62::service {
    struct Service<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        pay_to: address,
        name: 0x1::string::String,
        title: 0x1::string::String,
        endpoint: 0x1::string::String,
        category: 0x1::string::String,
        doc: 0x1::string::String,
        kind: u8,
        price: u64,
        active: bool,
        created_ms: u64,
    }

    struct ServiceCreated has copy, drop {
        service: 0x2::object::ID,
        owner: address,
        pay_to: address,
        name: 0x1::string::String,
        title: 0x1::string::String,
        endpoint: 0x1::string::String,
        category: 0x1::string::String,
        doc: 0x1::string::String,
        kind: u8,
        price: u64,
    }

    struct ServiceUpdated has copy, drop {
        service: 0x2::object::ID,
        pay_to: address,
        title: 0x1::string::String,
        endpoint: 0x1::string::String,
        category: 0x1::string::String,
        doc: 0x1::string::String,
        price: u64,
        active: bool,
    }

    struct ServicePaid<phantom T0> has copy, drop {
        service: 0x2::object::ID,
        payer: address,
        pay_to: address,
        amount: u64,
        nonce: vector<u8>,
        timestamp_ms: u64,
    }

    struct ServiceOwnerChanged has copy, drop {
        service: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    struct ServiceDeleted has copy, drop {
        service: 0x2::object::ID,
        owner: address,
    }

    public fun delete<T0>(arg0: Service<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 100);
        let Service {
            id         : v0,
            owner      : v1,
            pay_to     : _,
            name       : _,
            title      : _,
            endpoint   : _,
            category   : _,
            doc        : _,
            kind       : _,
            price      : _,
            active     : _,
            created_ms : _,
        } = arg0;
        let v12 = v0;
        let v13 = ServiceDeleted{
            service : 0x2::object::uid_to_inner(&v12),
            owner   : v1,
        };
        0x2::event::emit<ServiceDeleted>(v13);
        0x2::object::delete(v12);
    }

    public fun buy<T0>(arg0: &Service<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.kind == 0, 105);
        assert!(arg0.active, 108);
        assert!(arg0.price <= arg2, 109);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.price, 106);
        assert!(0x1::vector::length<u8>(&arg3) <= 64, 107);
        let v0 = ServicePaid<T0>{
            service      : 0x2::object::id<Service<T0>>(arg0),
            payer        : 0x2::tx_context::sender(arg5),
            pay_to       : arg0.pay_to,
            amount       : arg0.price,
            nonce        : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ServicePaid<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.pay_to);
    }

    public fun category<T0>(arg0: &Service<T0>) : 0x1::string::String {
        arg0.category
    }

    public fun create<T0>(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 == 0 || arg6 == 1, 104);
        assert!(arg7 > 0, 101);
        assert!(arg0 != @0x0, 103);
        assert!(0x1::vector::length<u8>(&arg1) <= 63, 102);
        assert!(0x1::vector::length<u8>(&arg2) <= 80, 102);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 102);
        assert!(0x1::vector::length<u8>(&arg4) <= 32, 102);
        assert!(0x1::vector::length<u8>(&arg5) <= 64, 102);
        let v0 = Service<T0>{
            id         : 0x2::object::new(arg9),
            owner      : 0x2::tx_context::sender(arg9),
            pay_to     : arg0,
            name       : 0x1::string::utf8(arg1),
            title      : 0x1::string::utf8(arg2),
            endpoint   : 0x1::string::utf8(arg3),
            category   : 0x1::string::utf8(arg4),
            doc        : 0x1::string::utf8(arg5),
            kind       : arg6,
            price      : arg7,
            active     : true,
            created_ms : 0x2::clock::timestamp_ms(arg8),
        };
        let v1 = ServiceCreated{
            service  : 0x2::object::id<Service<T0>>(&v0),
            owner    : v0.owner,
            pay_to   : arg0,
            name     : v0.name,
            title    : v0.title,
            endpoint : v0.endpoint,
            category : v0.category,
            doc      : v0.doc,
            kind     : arg6,
            price    : arg7,
        };
        0x2::event::emit<ServiceCreated>(v1);
        0x2::transfer::share_object<Service<T0>>(v0);
    }

    public fun doc<T0>(arg0: &Service<T0>) : 0x1::string::String {
        arg0.doc
    }

    public fun is_active<T0>(arg0: &Service<T0>) : bool {
        arg0.active
    }

    public fun is_api<T0>(arg0: &Service<T0>) : bool {
        arg0.kind == 0
    }

    public fun kind<T0>(arg0: &Service<T0>) : u8 {
        arg0.kind
    }

    public fun kind_api() : u8 {
        0
    }

    public fun kind_job() : u8 {
        1
    }

    public fun name<T0>(arg0: &Service<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun owner<T0>(arg0: &Service<T0>) : address {
        arg0.owner
    }

    public fun pay_to<T0>(arg0: &Service<T0>) : address {
        arg0.pay_to
    }

    public fun price<T0>(arg0: &Service<T0>) : u64 {
        arg0.price
    }

    public fun transfer_ownership<T0>(arg0: &mut Service<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 100);
        assert!(arg1 != @0x0, 103);
        arg0.owner = arg1;
        let v0 = ServiceOwnerChanged{
            service   : 0x2::object::id<Service<T0>>(arg0),
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<ServiceOwnerChanged>(v0);
    }

    public fun update<T0>(arg0: &mut Service<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: bool, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 100);
        assert!(arg6 > 0, 101);
        assert!(arg1 != @0x0, 103);
        assert!(0x1::vector::length<u8>(&arg2) <= 80, 102);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 102);
        assert!(0x1::vector::length<u8>(&arg4) <= 32, 102);
        assert!(0x1::vector::length<u8>(&arg5) <= 64, 102);
        arg0.pay_to = arg1;
        arg0.title = 0x1::string::utf8(arg2);
        arg0.endpoint = 0x1::string::utf8(arg3);
        arg0.category = 0x1::string::utf8(arg4);
        arg0.doc = 0x1::string::utf8(arg5);
        arg0.price = arg6;
        arg0.active = arg7;
        let v0 = ServiceUpdated{
            service  : 0x2::object::id<Service<T0>>(arg0),
            pay_to   : arg1,
            title    : arg0.title,
            endpoint : arg0.endpoint,
            category : arg0.category,
            doc      : arg0.doc,
            price    : arg6,
            active   : arg7,
        };
        0x2::event::emit<ServiceUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

