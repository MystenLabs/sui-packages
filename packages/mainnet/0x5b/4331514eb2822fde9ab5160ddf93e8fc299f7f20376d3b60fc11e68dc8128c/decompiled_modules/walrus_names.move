module 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names {
    struct WALRUS_NAMES has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WalNamesTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_base: u64,
        current_admin: address,
        pending_admin: 0x1::option::Option<address>,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<0x1::string::String, NameRecord>,
        total_registered: u64,
    }

    struct NameRecord has store {
        owner: address,
        blob_id: 0x1::string::String,
    }

    struct NameCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct NameRegistered has copy, drop {
        name: 0x1::string::String,
        owner: address,
        blob_id: 0x1::string::String,
    }

    struct BlobUpdated has copy, drop {
        name: 0x1::string::String,
        old_blob_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
    }

    struct NameTransferred has copy, drop {
        name: 0x1::string::String,
        from: address,
        to: address,
    }

    struct FeeUpdated has copy, drop {
        old_fee_base: u64,
        new_fee_base: u64,
    }

    struct AdminProposed has copy, drop {
        from: address,
        to: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct WhitelistAdded has copy, drop {
        wallet: address,
    }

    struct WhitelistRemoved has copy, drop {
        wallet: address,
    }

    public fun burn_publisher(arg0: 0x2::package::Publisher) {
        0x2::package::burn_publisher(arg0);
    }

    public fun accept_admin(arg0: AdminCap, arg1: &mut WalNamesTreasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::option::is_some<address>(&arg1.pending_admin), 9);
        assert!(*0x1::option::borrow<address>(&arg1.pending_admin) == v0, 10);
        arg1.pending_admin = 0x1::option::none<address>();
        arg1.current_admin = v0;
        let v1 = AdminTransferred{
            old_admin : arg1.current_admin,
            new_admin : v0,
        };
        0x2::event::emit<AdminTransferred>(v1);
        0x2::transfer::transfer<AdminCap>(arg0, v0);
    }

    public fun cancel_admin_proposal(arg0: &AdminCap, arg1: &mut WalNamesTreasury) {
        arg1.pending_admin = 0x1::option::none<address>();
    }

    public fun current_admin(arg0: &WalNamesTreasury) : address {
        arg0.current_admin
    }

    public fun fee_base(arg0: &WalNamesTreasury) : u64 {
        arg0.fee_base
    }

    fun init(arg0: WALRUS_NAMES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<WALRUS_NAMES>(arg0, arg1);
        let v2 = 0x2::display::new<NameCap>(&v1, arg1);
        0x2::display::add<NameCap>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}.epoch"));
        0x2::display::add<NameCap>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"41202e65706f6368206e616d65206f6e2045706f636820536974657320e2809420646563656e7472616c69736564207765627369746520686f7374696e67206f6e2057616c7275732026205375692e"));
        0x2::display::add<NameCap>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://og.epochsui.com/{name}"));
        0x2::display::add<NameCap>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://{name}.epochsui.com"));
        0x2::display::update_version<NameCap>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_freeze_object<0x2::display::Display<NameCap>>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, v0);
        let v4 = WalNamesTreasury{
            id            : 0x2::object::new(arg1),
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_base      : 500000000,
            current_admin : v0,
            pending_admin : 0x1::option::none<address>(),
            whitelist     : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<WalNamesTreasury>(v4);
        let v5 = Registry{
            id               : 0x2::object::new(arg1),
            records          : 0x2::table::new<0x1::string::String, NameRecord>(arg1),
            total_registered : 0,
        };
        0x2::transfer::share_object<Registry>(v5);
    }

    public fun is_available(arg0: &Registry, arg1: 0x1::string::String) : bool {
        !0x2::table::contains<0x1::string::String, NameRecord>(&arg0.records, arg1)
    }

    public fun is_whitelisted(arg0: &WalNamesTreasury, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun max_fee_base() : u64 {
        10000000000
    }

    public(friend) fun name_of(arg0: &NameCap) : 0x1::string::String {
        arg0.name
    }

    public fun owner_of(arg0: &Registry, arg1: 0x1::string::String) : address {
        assert!(0x2::table::contains<0x1::string::String, NameRecord>(&arg0.records, arg1), 6);
        0x2::table::borrow<0x1::string::String, NameRecord>(&arg0.records, arg1).owner
    }

    public fun propose_admin(arg0: &AdminCap, arg1: &mut WalNamesTreasury, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != 0x2::tx_context::sender(arg3), 11);
        assert!(0x1::option::is_none<address>(&arg1.pending_admin), 12);
        arg1.pending_admin = 0x1::option::some<address>(arg2);
        let v0 = AdminProposed{
            from : 0x2::tx_context::sender(arg3),
            to   : arg2,
        };
        0x2::event::emit<AdminProposed>(v0);
    }

    public fun register(arg0: &mut Registry, arg1: &mut WalNamesTreasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::as_bytes(&arg2);
        let v1 = 0x1::vector::length<u8>(v0);
        let v2 = 0x1::string::length(&arg3);
        assert!(v1 >= 3, 1);
        assert!(v1 <= 63, 2);
        assert!(v2 > 0, 5);
        assert!(v2 <= 256, 7);
        assert!(!0x2::table::contains<0x1::string::String, NameRecord>(&arg0.records, arg2), 0);
        validate_chars(v0);
        let v3 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<address, bool>(&arg1.whitelist, v3)) {
            if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v3);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
            };
        } else {
            let v4 = registration_fee(arg1.fee_base, v1);
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v4, 4);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v4, arg5)));
            if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v3);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
            };
        };
        let v5 = NameRecord{
            owner   : v3,
            blob_id : arg3,
        };
        0x2::table::add<0x1::string::String, NameRecord>(&mut arg0.records, arg2, v5);
        arg0.total_registered = arg0.total_registered + 1;
        let v6 = NameCap{
            id   : 0x2::object::new(arg5),
            name : arg2,
        };
        let v7 = NameRegistered{
            name    : v6.name,
            owner   : v3,
            blob_id : 0x2::table::borrow<0x1::string::String, NameRecord>(&arg0.records, v6.name).blob_id,
        };
        0x2::event::emit<NameRegistered>(v7);
        0x2::transfer::transfer<NameCap>(v6, v3);
    }

    public fun registration_fee(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 3) {
            arg0 * 25
        } else if (arg1 == 4) {
            arg0 * 5
        } else {
            arg0
        }
    }

    public fun resolve(arg0: &Registry, arg1: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<0x1::string::String, NameRecord>(&arg0.records, arg1)) {
            0x1::option::some<0x1::string::String>(0x2::table::borrow<0x1::string::String, NameRecord>(&arg0.records, arg1).blob_id)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun sync_owner(arg0: &mut Registry, arg1: &NameCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, NameRecord>(&mut arg0.records, arg1.name);
        v1.owner = v0;
        let v2 = NameTransferred{
            name : arg1.name,
            from : v1.owner,
            to   : v0,
        };
        0x2::event::emit<NameTransferred>(v2);
    }

    public fun total_registered(arg0: &Registry) : u64 {
        arg0.total_registered
    }

    public fun transfer_admin_to_pending(arg0: AdminCap, arg1: &WalNamesTreasury) {
        assert!(0x1::option::is_some<address>(&arg1.pending_admin), 9);
        0x2::transfer::transfer<AdminCap>(arg0, *0x1::option::borrow<address>(&arg1.pending_admin));
    }

    public fun transfer_name(arg0: &mut Registry, arg1: NameCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::borrow_mut<0x1::string::String, NameRecord>(&mut arg0.records, arg1.name).owner = arg2;
        let v0 = NameTransferred{
            name : arg1.name,
            from : 0x2::table::borrow<0x1::string::String, NameRecord>(&arg0.records, arg1.name).owner,
            to   : arg2,
        };
        0x2::event::emit<NameTransferred>(v0);
        0x2::transfer::transfer<NameCap>(arg1, arg2);
    }

    public(friend) fun treasury_balance_mut(arg0: &mut WalNamesTreasury) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.balance
    }

    public fun update_blob(arg0: &mut Registry, arg1: &NameCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::length(&arg2);
        assert!(v0 > 0, 5);
        assert!(v0 <= 256, 7);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, NameRecord>(&mut arg0.records, arg1.name);
        v1.blob_id = arg2;
        let v2 = BlobUpdated{
            name        : arg1.name,
            old_blob_id : v1.blob_id,
            new_blob_id : v1.blob_id,
        };
        0x2::event::emit<BlobUpdated>(v2);
    }

    public fun update_fee(arg0: &AdminCap, arg1: &mut WalNamesTreasury, arg2: u64) {
        assert!(arg2 <= 10000000000, 8);
        arg1.fee_base = arg2;
        let v0 = FeeUpdated{
            old_fee_base : arg1.fee_base,
            new_fee_base : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    fun validate_chars(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) != 45, 3);
        assert!(*0x1::vector::borrow<u8>(arg0, v0 - 1) != 45, 3);
        if (v0 >= 4) {
            let v1 = if (*0x1::vector::borrow<u8>(arg0, 0) == 120) {
                if (*0x1::vector::borrow<u8>(arg0, 1) == 110) {
                    if (*0x1::vector::borrow<u8>(arg0, 2) == 45) {
                        *0x1::vector::borrow<u8>(arg0, 3) == 45
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(!v1, 3);
        };
        let v2 = 0;
        let v3 = false;
        while (v2 < v0) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v2);
            let v5 = if (v4 >= 97 && v4 <= 122) {
                true
            } else if (v4 >= 48 && v4 <= 57) {
                true
            } else {
                v4 == 45
            };
            assert!(v5, 3);
            if (v4 >= 97 && v4 <= 122) {
                v3 = true;
            };
            if (v4 == 45 && v2 + 1 < v0) {
                assert!(*0x1::vector::borrow<u8>(arg0, v2 + 1) != 45, 3);
            };
            v2 = v2 + 1;
        };
        assert!(v3, 13);
    }

    public fun whitelist_add(arg0: &AdminCap, arg1: &mut WalNamesTreasury, arg2: address) {
        if (!0x2::table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.whitelist, arg2, true);
            let v0 = WhitelistAdded{wallet: arg2};
            0x2::event::emit<WhitelistAdded>(v0);
        };
    }

    public fun whitelist_remove(arg0: &AdminCap, arg1: &mut WalNamesTreasury, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
            let v0 = WhitelistRemoved{wallet: arg2};
            0x2::event::emit<WhitelistRemoved>(v0);
        };
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut WalNamesTreasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v7
}

