module 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book {
    struct BuilderRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Builder has drop, store {
        code: vector<u8>,
        payout: address,
        owner: address,
        share_bps: u16,
        active: bool,
    }

    struct BuilderRegistry has store, key {
        id: 0x2::object::UID,
        next_id: u32,
        builders: 0x2::table::Table<u32, Builder>,
        by_code: 0x2::table::Table<vector<u8>, u32>,
        by_payout: 0x2::table::Table<address, u32>,
        pending: 0x2::table::Table<address, u64>,
    }

    fun borrow(arg0: &0x2::object::UID, arg1: u32) : &Builder {
        0x2::table::borrow<u32, Builder>(&book(arg0).builders, arg1)
    }

    public fun active(arg0: &0x2::object::UID, arg1: u32) : bool {
        borrow(arg0, arg1).active
    }

    public(friend) fun add_pending(arg0: &mut 0x2::object::UID, arg1: address, arg2: u64) {
        let v0 = book_mut(arg0);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg1)) {
            0x2::table::add<address, u64>(&mut v0.pending, arg1, arg2);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.pending, arg1);
            *v1 = *v1 + arg2;
        };
    }

    public(friend) fun attach(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BuilderRegistryKey{dummy_field: false};
        let v1 = BuilderRegistry{
            id        : 0x2::object::new(arg1),
            next_id   : 1,
            builders  : 0x2::table::new<u32, Builder>(arg1),
            by_code   : 0x2::table::new<vector<u8>, u32>(arg1),
            by_payout : 0x2::table::new<address, u32>(arg1),
            pending   : 0x2::table::new<address, u64>(arg1),
        };
        0x2::dynamic_object_field::add<BuilderRegistryKey, BuilderRegistry>(arg0, v0, v1);
    }

    fun book(arg0: &0x2::object::UID) : &BuilderRegistry {
        let v0 = BuilderRegistryKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<BuilderRegistryKey, BuilderRegistry>(arg0, v0)
    }

    fun book_mut(arg0: &mut 0x2::object::UID) : &mut BuilderRegistry {
        let v0 = BuilderRegistryKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BuilderRegistryKey, BuilderRegistry>(arg0, v0)
    }

    public(friend) fun code(arg0: &0x2::object::UID, arg1: u32) : vector<u8> {
        borrow(arg0, arg1).code
    }

    public fun code_ok(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        v0 >= 1 && v0 <= 32
    }

    public fun code_taken(arg0: &0x2::object::UID, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u32>(&book(arg0).by_code, *arg1)
    }

    public fun exists(arg0: &0x2::object::UID, arg1: u32) : bool {
        0x2::table::contains<u32, Builder>(&book(arg0).builders, arg1)
    }

    public(friend) fun floor_cut(arg0: u64, arg1: u16, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        if (v0 > arg2) {
            arg2
        } else {
            v0
        }
    }

    public fun id_for_code(arg0: &0x2::object::UID, arg1: &vector<u8>) : 0x1::option::Option<u32> {
        let v0 = book(arg0);
        if (!0x2::table::contains<vector<u8>, u32>(&v0.by_code, *arg1)) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(*0x2::table::borrow<vector<u8>, u32>(&v0.by_code, *arg1))
        }
    }

    public fun owner(arg0: &0x2::object::UID, arg1: u32) : address {
        borrow(arg0, arg1).owner
    }

    public fun payout(arg0: &0x2::object::UID, arg1: u32) : address {
        borrow(arg0, arg1).payout
    }

    public fun payout_taken(arg0: &0x2::object::UID, arg1: address) : bool {
        0x2::table::contains<address, u32>(&book(arg0).by_payout, arg1)
    }

    public fun pending(arg0: &0x2::object::UID, arg1: address) : u64 {
        let v0 = book(arg0);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&v0.pending, arg1)
        }
    }

    public fun register(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>, arg3: address, arg4: address, arg5: u16) : u32 {
        let v0 = book_mut(arg1);
        let v1 = v0.next_id;
        v0.next_id = v1 + 1;
        let v2 = Builder{
            code      : arg2,
            payout    : arg3,
            owner     : arg4,
            share_bps : arg5,
            active    : true,
        };
        0x2::table::add<u32, Builder>(&mut v0.builders, v1, v2);
        0x2::table::add<vector<u8>, u32>(&mut v0.by_code, arg2, v1);
        0x2::table::add<address, u32>(&mut v0.by_payout, arg3, v1);
        v1
    }

    public fun set_active(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: u32, arg3: bool) {
        0x2::table::borrow_mut<u32, Builder>(&mut book_mut(arg1).builders, arg2).active = arg3;
    }

    public fun set_payout(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: u32, arg3: address) {
        let v0 = book_mut(arg1);
        let v1 = 0x2::table::borrow<u32, Builder>(&v0.builders, arg2).payout;
        if (v1 == arg3) {
            return
        };
        0x2::table::remove<address, u32>(&mut v0.by_payout, v1);
        0x2::table::add<address, u32>(&mut v0.by_payout, arg3, arg2);
        0x2::table::borrow_mut<u32, Builder>(&mut v0.builders, arg2).payout = arg3;
    }

    public fun set_share(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: u32, arg3: u16) {
        0x2::table::borrow_mut<u32, Builder>(&mut book_mut(arg1).builders, arg2).share_bps = arg3;
    }

    public fun share_bps(arg0: &0x2::object::UID, arg1: u32) : u16 {
        borrow(arg0, arg1).share_bps
    }

    public(friend) fun take_pending(arg0: &mut 0x2::object::UID, arg1: address) : u64 {
        let v0 = book_mut(arg0);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.pending, arg1);
        *v1 = 0;
        *v1
    }

    // decompiled from Move bytecode v7
}

