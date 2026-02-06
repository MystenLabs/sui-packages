module 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::dwallet_cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolSigningCap has key {
        id: 0x2::object::UID,
        dwallet_cap_id: address,
        dwallet_id: address,
        btc_pubkey: vector<u8>,
        btc_address: vector<u8>,
        is_active: bool,
        created_at_ms: u64,
    }

    struct PoolSigningCapCreated has copy, drop {
        cap_id: address,
        dwallet_cap_id: address,
        dwallet_id: address,
        btc_pubkey: vector<u8>,
        btc_address: vector<u8>,
    }

    struct PoolSigningCapDeactivated has copy, drop {
        cap_id: address,
    }

    struct PoolSigningCapUpdated has copy, drop {
        cap_id: address,
        new_dwallet_cap_id: address,
        new_dwallet_id: address,
        new_btc_pubkey: vector<u8>,
    }

    public entry fun activate_signing_cap(arg0: &AdminCap, arg1: &mut PoolSigningCap) {
        arg1.is_active = true;
    }

    public entry fun create_signing_cap(arg0: &AdminCap, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 == 33 || v0 == 65, 3);
        let v1 = PoolSigningCap{
            id             : 0x2::object::new(arg6),
            dwallet_cap_id : arg1,
            dwallet_id     : arg2,
            btc_pubkey     : arg3,
            btc_address    : arg4,
            is_active      : true,
            created_at_ms  : arg5,
        };
        let v2 = PoolSigningCapCreated{
            cap_id         : 0x2::object::uid_to_address(&v1.id),
            dwallet_cap_id : arg1,
            dwallet_id     : arg2,
            btc_pubkey     : v1.btc_pubkey,
            btc_address    : v1.btc_address,
        };
        0x2::event::emit<PoolSigningCapCreated>(v2);
        0x2::transfer::share_object<PoolSigningCap>(v1);
    }

    public entry fun deactivate_signing_cap(arg0: &AdminCap, arg1: &mut PoolSigningCap) {
        arg1.is_active = false;
        let v0 = PoolSigningCapDeactivated{cap_id: 0x2::object::uid_to_address(&arg1.id)};
        0x2::event::emit<PoolSigningCapDeactivated>(v0);
    }

    public fun get_btc_address(arg0: &PoolSigningCap) : vector<u8> {
        arg0.btc_address
    }

    public fun get_btc_pubkey(arg0: &PoolSigningCap) : vector<u8> {
        arg0.btc_pubkey
    }

    public fun get_created_at(arg0: &PoolSigningCap) : u64 {
        arg0.created_at_ms
    }

    public fun get_dwallet_cap_id(arg0: &PoolSigningCap) : address {
        arg0.dwallet_cap_id
    }

    public fun get_dwallet_id(arg0: &PoolSigningCap) : address {
        arg0.dwallet_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &PoolSigningCap) : bool {
        arg0.is_active
    }

    public entry fun update_dwallet(arg0: &AdminCap, arg1: &mut PoolSigningCap, arg2: address, arg3: address, arg4: vector<u8>, arg5: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg4);
        assert!(v0 == 33 || v0 == 65, 3);
        arg1.dwallet_cap_id = arg2;
        arg1.dwallet_id = arg3;
        arg1.btc_pubkey = arg4;
        arg1.btc_address = arg5;
        let v1 = PoolSigningCapUpdated{
            cap_id             : 0x2::object::uid_to_address(&arg1.id),
            new_dwallet_cap_id : arg2,
            new_dwallet_id     : arg3,
            new_btc_pubkey     : arg4,
        };
        0x2::event::emit<PoolSigningCapUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

