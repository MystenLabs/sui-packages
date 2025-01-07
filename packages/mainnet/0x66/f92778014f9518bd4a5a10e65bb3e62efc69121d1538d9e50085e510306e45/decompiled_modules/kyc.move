module 0x66f92778014f9518bd4a5a10e65bb3e62efc69121d1538d9e50085e510306e45::kyc {
    struct KYC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Kyc has store, key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, u8>,
    }

    struct AddKycEvent has copy, drop {
        users: vector<address>,
    }

    struct RemoveKycEvent has copy, drop {
        users: vector<address>,
    }

    public entry fun add(arg0: &AdminCap, arg1: vector<address>, arg2: &mut Kyc) {
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            assert!(!0x2::table::contains<address, u8>(&arg2.whitelist, v1), 1001);
            0x2::table::add<address, u8>(&mut arg2.whitelist, v1, 1);
        };
        let v2 = AddKycEvent{users: arg1};
        0x2::event::emit<AddKycEvent>(v2);
    }

    public entry fun remove(arg0: &AdminCap, arg1: vector<address>, arg2: &mut Kyc) {
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            assert!(0x2::table::contains<address, u8>(&arg2.whitelist, v1), 1002);
            0x2::table::remove<address, u8>(&mut arg2.whitelist, v1);
        };
        let v2 = RemoveKycEvent{users: arg1};
        0x2::event::emit<RemoveKycEvent>(v2);
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun hasKYC(arg0: address, arg1: &Kyc) : bool {
        0x2::table::contains<address, u8>(&arg1.whitelist, arg0)
    }

    fun init(arg0: KYC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Kyc{
            id        : 0x2::object::new(arg1),
            whitelist : 0x2::table::new<address, u8>(arg1),
        };
        0x2::transfer::share_object<Kyc>(v1);
    }

    // decompiled from Move bytecode v6
}

