module 0xd914d5a014cfc10057781da23adadb608e3b08fac2cc39fcaaa9c1e5922661a1::lottery {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryConfig has key {
        id: 0x2::object::UID,
        admin: address,
        loss_fee_bps: u64,
    }

    struct Lottery has key {
        id: 0x2::object::UID,
        creator: address,
        slots: vector<bool>,
        winner: 0x1::option::Option<address>,
        winning_slot: u64,
        last_picker: 0x1::option::Option<address>,
        last_slot: u64,
        prize: 0x2::balance::Balance<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>,
        remaining_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
    }

    struct LotteryCreatedEvent has copy, drop, store {
        lottery_id: 0x2::object::ID,
        creator: address,
        slot_count: u64,
        prize: u64,
        fee: u64,
    }

    struct PickedEvent has copy, drop, store {
        lottery_id: 0x2::object::ID,
        slot_index: u64,
        won: bool,
        random_number: u64,
    }

    public fun collect_fee(arg0: &mut Lottery, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.remaining_fee);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.remaining_fee, v0), arg1), arg0.creator);
        };
    }

    public fun collect_prize(arg0: &mut Lottery, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.winner), 6);
        let v0 = *0x1::option::borrow<address>(&arg0.winner);
        assert!(0x2::tx_context::sender(arg1) == v0, 5);
        let v1 = 0x2::balance::value<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>(&arg0.prize);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>>(0x2::coin::from_balance<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>(0x2::balance::split<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>(&mut arg0.prize, v1), arg1), v0);
        };
    }

    fun count_unpicked_slots(arg0: &vector<bool>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<bool>(arg0)) {
            if (*0x1::vector::borrow<bool>(arg0, v1) == false) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_lottery(arg0: 0x2::coin::Coin<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Lottery{
            id            : 0x2::object::new(arg2),
            creator       : v0,
            slots         : make_empty_vec(9),
            winner        : 0x1::option::none<address>(),
            winning_slot  : 0,
            last_picker   : 0x1::option::none<address>(),
            last_slot     : 0,
            prize         : 0x2::coin::into_balance<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>(arg0),
            remaining_fee : 0x2::balance::zero<0x2::sui::SUI>(),
            fee           : arg1,
        };
        let v2 = LotteryCreatedEvent{
            lottery_id : 0x2::object::id<Lottery>(&v1),
            creator    : v0,
            slot_count : 9,
            prize      : 0x2::coin::value<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>(&arg0),
            fee        : arg1,
        };
        0x2::event::emit<LotteryCreatedEvent>(v2);
        0x2::transfer::share_object<Lottery>(v1);
    }

    fun fill(arg0: &mut vector<bool>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        0x1::vector::push_back<bool>(arg0, false);
        fill(arg0, arg1 - 1);
    }

    public fun get_config_admin(arg0: &LotteryConfig) : address {
        arg0.admin
    }

    public fun get_config_loss_fee_bps(arg0: &LotteryConfig) : u64 {
        arg0.loss_fee_bps
    }

    public fun get_creator(arg0: &Lottery) : address {
        arg0.creator
    }

    public fun get_fee(arg0: &Lottery) : u64 {
        arg0.fee
    }

    public fun get_last_picker(arg0: &Lottery) : 0x1::option::Option<address> {
        arg0.last_picker
    }

    public fun get_last_slot(arg0: &Lottery) : u64 {
        arg0.last_slot
    }

    public fun get_prize(arg0: &Lottery) : u64 {
        0x2::balance::value<0xe0fbaffa16409259e431b3e1ff97bf6129641945b42e5e735c99aeda73a595ac::suiyan::SUIYAN>(&arg0.prize)
    }

    public fun get_remaining_fee(arg0: &Lottery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.remaining_fee)
    }

    public fun get_slot(arg0: &Lottery, arg1: u64) : bool {
        *0x1::vector::borrow<bool>(&arg0.slots, arg1)
    }

    public fun get_slots_length(arg0: &Lottery) : u64 {
        0x1::vector::length<bool>(&arg0.slots)
    }

    public fun get_winner(arg0: &Lottery) : 0x1::option::Option<address> {
        arg0.winner
    }

    public fun get_winning_slot(arg0: &Lottery) : u64 {
        arg0.winning_slot
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = LotteryConfig{
            id           : 0x2::object::new(arg0),
            admin        : v0,
            loss_fee_bps : 500,
        };
        0x2::transfer::share_object<LotteryConfig>(v2);
    }

    public fun is_active(arg0: &Lottery) : bool {
        0x1::option::is_none<address>(&arg0.winner)
    }

    fun make_empty_vec(arg0: u64) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = &mut v0;
        fill(v1, arg0);
        v0
    }

    entry fun pick_slot(arg0: u64, arg1: &mut Lottery, arg2: &LotteryConfig, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::option::is_none<address>(&arg1.winner), 1);
        assert!(*0x1::vector::borrow<bool>(&arg1.slots, arg0) == false, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg1.fee, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.remaining_fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        *0x1::vector::borrow_mut<bool>(&mut arg1.slots, arg0) = true;
        let (v0, v1) = if (count_unpicked_slots(&arg1.slots) == 0) {
            (0, true)
        } else {
            let v2 = 0x2::random::new_generator(arg3, arg5);
            let v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, 10000);
            (v3, v3 < 10000 / 0x1::vector::length<bool>(&arg1.slots))
        };
        if (v1) {
            arg1.winner = 0x1::option::some<address>(0x2::tx_context::sender(arg5));
            arg1.winning_slot = arg0;
        } else {
            arg1.last_picker = 0x1::option::some<address>(0x2::tx_context::sender(arg5));
            arg1.last_slot = arg0;
            let v4 = arg1.fee * arg2.loss_fee_bps / 10000;
            if (v4 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg1.remaining_fee) >= v4) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.remaining_fee, v4), arg5), arg2.admin);
            };
        };
        let v5 = PickedEvent{
            lottery_id    : 0x2::object::id<Lottery>(arg1),
            slot_index    : arg0,
            won           : v1,
            random_number : v0,
        };
        0x2::event::emit<PickedEvent>(v5);
        v0
    }

    public fun slot_count() : u64 {
        9
    }

    public fun update_admin(arg0: &AdminCap, arg1: &mut LotteryConfig, arg2: address) {
        arg1.admin = arg2;
    }

    public fun update_loss_fee(arg0: &AdminCap, arg1: &mut LotteryConfig, arg2: u64) {
        arg1.loss_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

