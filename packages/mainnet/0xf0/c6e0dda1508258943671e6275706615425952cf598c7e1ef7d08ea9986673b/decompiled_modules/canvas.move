module 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Canvas has key {
        id: 0x2::object::UID,
        launched: bool,
        paused: bool,
        width_cells: u16,
        height_cells: u16,
        chunk_size: u16,
        chunks_x: u16,
        chunks_y: u16,
        starts_at_ms: u64,
        scheduled_ends_at_ms: u64,
        effective_ends_at_ms: u64,
        treasury: address,
        base_price_mist: u64,
        initial_growth_bps: u64,
        price_tick_mist: u64,
        refund_bps: u64,
        so_per_sui: u64,
        network_id: u8,
        max_so_discount_bps: u64,
        discount_signer_public_key: vector<u8>,
        discount_signer_version: u64,
        discounts_paused: bool,
    }

    struct Chunk has key {
        id: 0x2::object::UID,
        canvas_id: 0x2::object::ID,
        chunk_x: u16,
        chunk_y: u16,
    }

    struct Cell has store {
        owner: address,
        voice_id: 0x2::object::ID,
        price_mist: u64,
        purchase_count: u64,
    }

    struct CellApplicationResult has copy, drop {
        previous_owner: 0x1::option::Option<address>,
        previous_voice_id: 0x1::option::Option<0x2::object::ID>,
        previous_price_mist: u64,
        price_mist: u64,
        gross_price_mist: u64,
        refund_so: u64,
        purchase_count: u64,
        ownership_changed: bool,
    }

    struct ChunkRef has copy, drop {
        id: 0x2::object::ID,
        chunk_x: u16,
        chunk_y: u16,
    }

    struct CanvasCreated has copy, drop {
        canvas_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct CanvasLaunched has copy, drop {
        canvas_id: 0x2::object::ID,
        width_cells: u16,
        height_cells: u16,
        chunk_size: u16,
        chunks_x: u16,
        chunks_y: u16,
        starts_at_ms: u64,
        scheduled_ends_at_ms: u64,
        treasury: address,
        base_price_mist: u64,
        initial_growth_bps: u64,
        price_tick_mist: u64,
        refund_bps: u64,
        so_per_sui: u64,
        network_id: u8,
        max_so_discount_bps: u64,
        discount_signer_public_key: vector<u8>,
        discount_signer_version: u64,
        discounts_paused: bool,
        chunks: vector<ChunkRef>,
    }

    struct CanvasClosedEarly has copy, drop {
        canvas_id: 0x2::object::ID,
        ended_at_ms: u64,
        scheduled_ends_at_ms: u64,
    }

    struct PauseChanged has copy, drop {
        canvas_id: 0x2::object::ID,
        paused: bool,
        changed_at_ms: u64,
    }

    struct DiscountPauseChanged has copy, drop {
        canvas_id: 0x2::object::ID,
        paused: bool,
        changed_at_ms: u64,
    }

    struct DiscountSignerRotated has copy, drop {
        canvas_id: 0x2::object::ID,
        public_key: vector<u8>,
        signer_version: u64,
        changed_at_ms: u64,
    }

    public(friend) fun application_gross_price_mist(arg0: &CellApplicationResult) : u64 {
        arg0.gross_price_mist
    }

    public(friend) fun application_ownership_changed(arg0: &CellApplicationResult) : bool {
        arg0.ownership_changed
    }

    public(friend) fun application_previous_owner(arg0: &CellApplicationResult) : 0x1::option::Option<address> {
        arg0.previous_owner
    }

    public(friend) fun application_previous_price_mist(arg0: &CellApplicationResult) : u64 {
        arg0.previous_price_mist
    }

    public(friend) fun application_previous_voice_id(arg0: &CellApplicationResult) : 0x1::option::Option<0x2::object::ID> {
        arg0.previous_voice_id
    }

    public(friend) fun application_price_mist(arg0: &CellApplicationResult) : u64 {
        arg0.price_mist
    }

    public(friend) fun application_purchase_count(arg0: &CellApplicationResult) : u64 {
        arg0.purchase_count
    }

    public(friend) fun application_refund_so(arg0: &CellApplicationResult) : u64 {
        arg0.refund_so
    }

    public(friend) fun apply_cell_to_voice(arg0: &Canvas, arg1: &mut Chunk, arg2: address, arg3: 0x2::object::ID, arg4: u16, arg5: u16, arg6: u64) : CellApplicationResult {
        assert_canvas_available(arg0, arg6);
        assert!(arg4 < arg0.width_cells && arg5 < arg0.height_cells, 9);
        let v0 = if (arg1.canvas_id == 0x2::object::id<Canvas>(arg0)) {
            if (arg1.chunk_x == arg4 / 20) {
                arg1.chunk_y == arg5 / 20
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
        let v1 = local_cell_index(arg4, arg5);
        if (0x2::dynamic_field::exists_with_type<u16, Cell>(&arg1.id, v1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<u16, Cell>(&mut arg1.id, v1);
            let v4 = v3.owner;
            let v5 = v3.price_mist;
            if (v4 == arg2) {
                v3.voice_id = arg3;
                CellApplicationResult{previous_owner: 0x1::option::some<address>(v4), previous_voice_id: 0x1::option::some<0x2::object::ID>(v3.voice_id), previous_price_mist: v5, price_mist: v5, gross_price_mist: 0, refund_so: 0, purchase_count: v3.purchase_count, ownership_changed: false}
            } else {
                let v6 = next_cell_price(arg0, v5);
                let v7 = v3.purchase_count + 1;
                v3.owner = arg2;
                v3.voice_id = arg3;
                v3.price_mist = v6;
                v3.purchase_count = v7;
                CellApplicationResult{previous_owner: 0x1::option::some<address>(v4), previous_voice_id: 0x1::option::some<0x2::object::ID>(v3.voice_id), previous_price_mist: v5, price_mist: v6, gross_price_mist: v6, refund_so: calculate_refund_so(arg0, v5), purchase_count: v7, ownership_changed: true}
            }
        } else {
            let v8 = arg0.base_price_mist;
            let v9 = Cell{
                owner          : arg2,
                voice_id       : arg3,
                price_mist     : v8,
                purchase_count : 1,
            };
            0x2::dynamic_field::add<u16, Cell>(&mut arg1.id, v1, v9);
            CellApplicationResult{previous_owner: 0x1::option::none<address>(), previous_voice_id: 0x1::option::none<0x2::object::ID>(), previous_price_mist: 0, price_mist: v8, gross_price_mist: v8, refund_so: 0, purchase_count: 1, ownership_changed: true}
        }
    }

    public(friend) fun assert_available(arg0: &Canvas, arg1: u64) {
        assert_canvas_available(arg0, arg1);
    }

    fun assert_canvas_available(arg0: &Canvas, arg1: u64) {
        assert!(arg0.launched, 5);
        assert!(!arg0.paused, 1);
        assert!(arg1 < arg0.effective_ends_at_ms, 6);
    }

    fun assert_dimensions(arg0: u16, arg1: u16) {
        let v0 = if (arg0 >= 20) {
            if (arg0 <= 600) {
                if (arg1 >= 20) {
                    if (arg1 <= 600) {
                        if (arg0 % 20 == 0) {
                            arg1 % 20 == 0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
    }

    public(friend) fun assert_discounts_available(arg0: &Canvas) {
        assert!(!arg0.discounts_paused, 19);
    }

    fun calculate_refund_so(arg0: &Canvas, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (arg0.refund_bps as u128) * (arg0.so_per_sui as u128) / (10000 as u128) * (1000000000 as u128);
        let v1 = if (v0 == 0) {
            1
        } else {
            v0
        };
        assert!(v1 <= 18446744073709551615, 15);
        (v1 as u64)
    }

    fun ceil_div(arg0: u128, arg1: u128) : u128 {
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    public(friend) fun chunk_canvas_id_internal(arg0: &Chunk) : 0x2::object::ID {
        arg0.canvas_id
    }

    public(friend) fun chunk_size_internal() : u16 {
        20
    }

    public(friend) fun chunk_x_internal(arg0: &Chunk) : u16 {
        arg0.chunk_x
    }

    public(friend) fun chunk_y_internal(arg0: &Chunk) : u16 {
        arg0.chunk_y
    }

    public(friend) fun discount_signer_public_key_internal(arg0: &Canvas) : &vector<u8> {
        &arg0.discount_signer_public_key
    }

    public(friend) fun discount_signer_version_internal(arg0: &Canvas) : u64 {
        arg0.discount_signer_version
    }

    public fun emergency_close(arg0: &AdminCap, arg1: &mut Canvas, arg2: &0x2::clock::Clock) {
        assert!(arg1.launched, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg1.effective_ends_at_ms, 6);
        arg1.effective_ends_at_ms = v0;
        let v1 = CanvasClosedEarly{
            canvas_id            : 0x2::object::id<Canvas>(arg1),
            ended_at_ms          : v0,
            scheduled_ends_at_ms : arg1.scheduled_ends_at_ms,
        };
        0x2::event::emit<CanvasClosedEarly>(v1);
    }

    public(friend) fun height_cells(arg0: &Canvas) : u16 {
        arg0.height_cells
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Canvas{
            id                         : 0x2::object::new(arg0),
            launched                   : false,
            paused                     : false,
            width_cells                : 0,
            height_cells               : 0,
            chunk_size                 : 20,
            chunks_x                   : 0,
            chunks_y                   : 0,
            starts_at_ms               : 0,
            scheduled_ends_at_ms       : 0,
            effective_ends_at_ms       : 0,
            treasury                   : @0x0,
            base_price_mist            : 0,
            initial_growth_bps         : 0,
            price_tick_mist            : 100000000,
            refund_bps                 : 0,
            so_per_sui                 : 0,
            network_id                 : 0,
            max_so_discount_bps        : 0,
            discount_signer_public_key : b"",
            discount_signer_version    : 0,
            discounts_paused           : true,
        };
        let v2 = CanvasCreated{
            canvas_id    : 0x2::object::id<Canvas>(&v1),
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::event::emit<CanvasCreated>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Canvas>(v1);
    }

    public fun launch_canvas(arg0: &AdminCap, arg1: &mut Canvas, arg2: u16, arg3: u16, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.launched, 0);
        assert!(!arg1.paused, 1);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(arg4 > v0, 2);
        assert_dimensions(arg2, arg3);
        assert!(arg5 != @0x0, 7);
        let v1 = if (arg6 > 0) {
            if (arg6 % 100000000 == 0) {
                if (arg7 > 0) {
                    arg7 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 8);
        let v2 = if (arg8 > 0) {
            if (arg8 <= 10000) {
                if (arg9 > 0) {
                    arg9 <= 1000000000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 14);
        let v3 = if (arg10 <= 3) {
            if (arg11 > 0) {
                arg11 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 16);
        assert!(0x1::vector::length<u8>(&arg12) == 32, 17);
        let v4 = arg2 / 20;
        let v5 = arg3 / 20;
        assert!((v4 as u64) * (v5 as u64) <= 500, 4);
        let v6 = 0x2::object::id<Canvas>(arg1);
        let v7 = 0x1::vector::empty<ChunkRef>();
        let v8 = 0;
        while (v8 < v5) {
            let v9 = 0;
            while (v9 < v4) {
                let v10 = Chunk{
                    id        : 0x2::object::new(arg14),
                    canvas_id : v6,
                    chunk_x   : v9,
                    chunk_y   : v8,
                };
                let v11 = ChunkRef{
                    id      : 0x2::object::id<Chunk>(&v10),
                    chunk_x : v9,
                    chunk_y : v8,
                };
                0x1::vector::push_back<ChunkRef>(&mut v7, v11);
                0x2::transfer::share_object<Chunk>(v10);
                v9 = v9 + 1;
            };
            v8 = v8 + 1;
        };
        arg1.launched = true;
        arg1.width_cells = arg2;
        arg1.height_cells = arg3;
        arg1.chunks_x = v4;
        arg1.chunks_y = v5;
        arg1.starts_at_ms = v0;
        arg1.scheduled_ends_at_ms = arg4;
        arg1.effective_ends_at_ms = arg4;
        arg1.treasury = arg5;
        arg1.base_price_mist = arg6;
        arg1.initial_growth_bps = arg7;
        arg1.refund_bps = arg8;
        arg1.so_per_sui = arg9;
        arg1.network_id = arg10;
        arg1.max_so_discount_bps = arg11;
        arg1.discount_signer_public_key = arg12;
        arg1.discount_signer_version = 1;
        arg1.discounts_paused = false;
        let v12 = CanvasLaunched{
            canvas_id                  : v6,
            width_cells                : arg2,
            height_cells               : arg3,
            chunk_size                 : 20,
            chunks_x                   : v4,
            chunks_y                   : v5,
            starts_at_ms               : v0,
            scheduled_ends_at_ms       : arg4,
            treasury                   : arg5,
            base_price_mist            : arg6,
            initial_growth_bps         : arg7,
            price_tick_mist            : 100000000,
            refund_bps                 : arg8,
            so_per_sui                 : arg9,
            network_id                 : arg10,
            max_so_discount_bps        : arg11,
            discount_signer_public_key : arg1.discount_signer_public_key,
            discount_signer_version    : arg1.discount_signer_version,
            discounts_paused           : arg1.discounts_paused,
            chunks                     : v7,
        };
        0x2::event::emit<CanvasLaunched>(v12);
    }

    fun local_cell_index(arg0: u16, arg1: u16) : u16 {
        arg1 % 20 * 20 + arg0 % 20
    }

    public(friend) fun max_so_discount_bps_internal(arg0: &Canvas) : u64 {
        arg0.max_so_discount_bps
    }

    public(friend) fun network_id_internal(arg0: &Canvas) : u8 {
        arg0.network_id
    }

    fun next_cell_price(arg0: &Canvas, arg1: u64) : u64 {
        let v0 = (arg1 as u128);
        let v1 = (arg0.base_price_mist as u128) * 10;
        let v2 = 1;
        while (v0 >= v1) {
            v1 = v1 * 10;
            v2 = v2 * 2;
        };
        let v3 = ceil_div(v0 + ceil_div(v0 * (arg0.initial_growth_bps as u128), (10000 as u128) * v2), (arg0.price_tick_mist as u128)) * (arg0.price_tick_mist as u128);
        assert!(v3 <= 18446744073709551615, 13);
        (v3 as u64)
    }

    public(friend) fun register_so_pass(arg0: &mut Canvas, arg1: address, arg2: 0x2::object::ID) {
        assert!(!0x2::dynamic_field::exists_with_type<address, 0x2::object::ID>(&arg0.id, arg1), 20);
        0x2::dynamic_field::add<address, 0x2::object::ID>(&mut arg0.id, arg1, arg2);
    }

    public fun rotate_discount_signer(arg0: &AdminCap, arg1: &mut Canvas, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(arg1.launched, 5);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 17);
        assert!(arg1.discount_signer_version < 18446744073709551615, 18);
        arg1.discount_signer_public_key = arg2;
        arg1.discount_signer_version = arg1.discount_signer_version + 1;
        arg1.discounts_paused = true;
        let v0 = DiscountSignerRotated{
            canvas_id      : 0x2::object::id<Canvas>(arg1),
            public_key     : arg1.discount_signer_public_key,
            signer_version : arg1.discount_signer_version,
            changed_at_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DiscountSignerRotated>(v0);
        let v1 = DiscountPauseChanged{
            canvas_id     : 0x2::object::id<Canvas>(arg1),
            paused        : true,
            changed_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DiscountPauseChanged>(v1);
    }

    public fun set_discounts_paused(arg0: &AdminCap, arg1: &mut Canvas, arg2: bool, arg3: &0x2::clock::Clock) {
        assert!(arg1.launched, 5);
        arg1.discounts_paused = arg2;
        let v0 = DiscountPauseChanged{
            canvas_id     : 0x2::object::id<Canvas>(arg1),
            paused        : arg2,
            changed_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DiscountPauseChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Canvas, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        let v0 = PauseChanged{
            canvas_id     : 0x2::object::id<Canvas>(arg1),
            paused        : arg2,
            changed_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public(friend) fun so_per_sui_internal(arg0: &Canvas) : u64 {
        arg0.so_per_sui
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        assert!(arg1 != @0x0, 21);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public(friend) fun treasury(arg0: &Canvas) : address {
        arg0.treasury
    }

    public(friend) fun width_cells(arg0: &Canvas) : u16 {
        arg0.width_cells
    }

    // decompiled from Move bytecode v7
}

