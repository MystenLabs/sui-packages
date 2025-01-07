module 0xcafcaaceec61b44d0de710f26b578f639740a77814a4e4ddbd02fc30c8a6e604::scratch_off {
    struct NewDrawing<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        player: address,
    }

    struct DrawingResult<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        player: address,
        amount_won: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        convenience_store_id: 0x2::object::ID,
        player: address,
    }

    struct PrizeStruct has drop, store {
        ticket_amount: u64,
        prize_value: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ScratchOff has copy, drop {
        dummy_field: bool,
    }

    struct SCRATCH_OFF has drop {
        dummy_field: bool,
    }

    struct ConvenienceStore<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        tickets: vector<PrizeStruct>,
        original_ticket_count: u64,
        tickets_issued: u64,
        ticket_cost: u64,
        game_count: u64,
        public_key: vector<u8>,
    }

    public fun buy_ticket<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut ConvenienceStore<T0>, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : Ticket {
        assert!(arg1.tickets_issued < arg1.original_ticket_count, 2);
        arg1.tickets_issued = arg1.tickets_issued + 1;
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 == arg1.ticket_cost, 3);
        let v1 = ScratchOff{dummy_field: false};
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::add_volume<T0, ScratchOff>(v1, arg0, v0, arg4);
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::put<T0, ScratchOff>(v1, arg0, arg2);
        Ticket{
            id                   : 0x2::object::new(arg4),
            convenience_store_id : 0x2::object::uid_to_inner(&arg1.id),
            player               : arg3,
        }
    }

    public fun evaluate_ticket<T0>(arg0: Ticket, arg1: &mut ConvenienceStore<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.tickets_issued <= arg1.original_ticket_count, 2);
        assert!(0x2::object::id<ConvenienceStore<T0>>(arg1) == arg0.convenience_store_id, 4);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        arg0.player = 0x2::tx_context::sender(arg2);
        0x2::dynamic_object_field::add<0x2::object::ID, Ticket>(&mut arg1.id, v0, arg0);
        let v1 = NewDrawing<T0>{
            ticket_id : v0,
            player    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NewDrawing<T0>>(v1);
        v0
    }

    public fun finish_evaluation<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut ConvenienceStore<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (!ticket_exists<T0>(arg3, arg1)) {
            return
        };
        let Ticket {
            id                   : v0,
            convenience_store_id : _,
            player               : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Ticket>(&mut arg3.id, arg1);
        let v3 = v0;
        let v4 = 0x2::object::uid_to_bytes(&v3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg3.public_key, &v4), 1);
        0x2::object::delete(v3);
        let v5 = 0x2::hash::blake2b256(&arg2);
        let v6 = 0xcafcaaceec61b44d0de710f26b578f639740a77814a4e4ddbd02fc30c8a6e604::math::get_random_u64_in_range(&v5, tickets_left<T0>(arg3));
        let v7 = 0;
        let v8 = 0;
        while (v7 < v6) {
            v7 = v7 + 0x1::vector::borrow<PrizeStruct>(&arg3.tickets, v8).ticket_amount;
            if (v7 < v6) {
                v8 = v8 + 1;
            };
        };
        let v9 = 0x1::vector::remove<PrizeStruct>(&mut arg3.tickets, v8);
        let v10 = ScratchOff{dummy_field: false};
        v9.ticket_amount = v9.ticket_amount - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::take<T0, ScratchOff>(v10, arg0, v9.prize_value, arg4), v2);
        if (v9.ticket_amount > 0) {
            0x1::vector::push_back<PrizeStruct>(&mut arg3.tickets, v9);
        };
        arg3.game_count = arg3.game_count + 1;
        let v11 = DrawingResult<T0>{
            ticket_id  : arg1,
            player     : 0x2::tx_context::sender(arg4),
            amount_won : v9.prize_value,
        };
        0x2::event::emit<DrawingResult<T0>>(v11);
    }

    public fun game_count<T0>(arg0: &ConvenienceStore<T0>) : u64 {
        arg0.game_count
    }

    fun init(arg0: SCRATCH_OFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<SCRATCH_OFF>(arg0, arg1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun open_store<T0>(arg0: &AdminCap, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0x1::vector::empty<PrizeStruct>();
        let v2 = 0;
        let v3 = 0;
        while (v2 < v0) {
            let v4 = 0x1::vector::pop_back<u64>(&mut arg1);
            let v5 = PrizeStruct{
                ticket_amount : v4,
                prize_value   : 0x1::vector::pop_back<u64>(&mut arg2),
            };
            0x1::vector::push_back<PrizeStruct>(&mut v1, v5);
            v3 = v3 + v4;
            v2 = v2 + 1;
        };
        let v6 = ConvenienceStore<T0>{
            id                    : 0x2::object::new(arg5),
            creator               : 0x2::tx_context::sender(arg5),
            tickets               : v1,
            original_ticket_count : v3,
            tickets_issued        : 0,
            ticket_cost           : arg4,
            game_count            : 0,
            public_key            : arg3,
        };
        0x2::transfer::share_object<ConvenienceStore<T0>>(v6);
    }

    public fun original_ticket_count<T0>(arg0: &ConvenienceStore<T0>) : u64 {
        arg0.original_ticket_count
    }

    public fun public_key<T0>(arg0: &ConvenienceStore<T0>) : vector<u8> {
        arg0.public_key
    }

    public fun ticket_exists<T0>(arg0: &ConvenienceStore<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Ticket>(&arg0.id, arg1)
    }

    public fun tickets<T0>(arg0: &ConvenienceStore<T0>) : &vector<PrizeStruct> {
        &arg0.tickets
    }

    public fun tickets_issued<T0>(arg0: &ConvenienceStore<T0>) : u64 {
        arg0.tickets_issued
    }

    public fun tickets_left<T0>(arg0: &ConvenienceStore<T0>) : u64 {
        arg0.original_ticket_count - arg0.game_count
    }

    // decompiled from Move bytecode v6
}

