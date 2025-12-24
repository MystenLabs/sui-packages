module 0xf8912f2d995116956fefb8e293251cf13c4cf0fd91cdce6272963ac6646ec006::rank_list {
    struct RankItem has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct TodayRank has key {
        id: 0x2::object::UID,
        day: u64,
        items: vector<RankItem>,
    }

    public(friend) fun add_performance(arg0: &mut TodayRank, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = current_day(arg3);
        if (arg0.day != v0) {
            arg0.day = v0;
            arg0.items = 0x1::vector::empty<RankItem>();
        };
        let v1 = &mut arg0.items;
        update_top30(v1, arg1, arg2);
    }

    fun bubble_up(arg0: &mut vector<RankItem>, arg1: u64) {
        while (arg1 > 0) {
            arg1 = arg1 - 1;
            if (0x1::vector::borrow<RankItem>(arg0, arg1).amount > 0x1::vector::borrow<RankItem>(arg0, arg1).amount) {
                0x1::vector::swap<RankItem>(arg0, arg1, arg1);
            } else {
                break
            };
        };
    }

    fun current_day(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 86400000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TodayRank{
            id    : 0x2::object::new(arg0),
            day   : 0,
            items : 0x1::vector::empty<RankItem>(),
        };
        0x2::transfer::share_object<TodayRank>(v0);
    }

    fun insert_sorted(arg0: &mut vector<RankItem>, arg1: RankItem) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RankItem>(arg0)) {
            if (arg1.amount > 0x1::vector::borrow<RankItem>(arg0, v0).amount) {
                0x1::vector::insert<RankItem>(arg0, arg1, v0);
                return
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<RankItem>(arg0, arg1);
    }

    fun update_top30(arg0: &mut vector<RankItem>, arg1: address, arg2: u64) {
        let v0 = 0x1::vector::length<RankItem>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow_mut<RankItem>(arg0, v1);
            if (v2.user == arg1) {
                v2.amount = v2.amount + arg2;
                bubble_up(arg0, v1);
                return
            };
            v1 = v1 + 1;
        };
        if (v0 < 30) {
            let v3 = RankItem{
                user   : arg1,
                amount : arg2,
            };
            insert_sorted(arg0, v3);
            return
        };
        if (arg2 <= 0x1::vector::borrow<RankItem>(arg0, v0 - 1).amount) {
            return
        };
        let v4 = RankItem{
            user   : arg1,
            amount : arg2,
        };
        insert_sorted(arg0, v4);
        0x1::vector::pop_back<RankItem>(arg0);
    }

    // decompiled from Move bytecode v6
}

