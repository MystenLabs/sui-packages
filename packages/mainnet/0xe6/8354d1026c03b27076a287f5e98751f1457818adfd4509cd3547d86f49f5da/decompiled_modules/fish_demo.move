module 0xe68354d1026c03b27076a287f5e98751f1457818adfd4509cd3547d86f49f5da::fish_demo {
    struct Fish has store, key {
        id: 0x2::object::UID,
        type_fish: 0x1::string::String,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        fishes: vector<Fish>,
        total_amount: u64,
    }

    struct Player has store, key {
        id: 0x2::object::UID,
        store: vector<Fish>,
    }

    public entry fun add_pool(arg0: &mut Pool, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = Fish{
                id        : 0x2::object::new(arg3),
                type_fish : 0x1::string::utf8(arg2),
            };
            0x1::vector::push_back<Fish>(&mut arg0.fishes, v1);
            v0 = v0 + 1;
        };
        arg0.total_amount = 0x1::vector::length<Fish>(&mut arg0.fishes);
    }

    public entry fun fishing_last_one(arg0: &mut Pool, arg1: &mut Player, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.total_amount = 0x1::vector::length<Fish>(&mut arg0.fishes);
        0x1::vector::push_back<Fish>(&mut arg1.store, 0x1::vector::pop_back<Fish>(&mut arg0.fishes));
    }

    public entry fun fishing_random_one(arg0: &mut Pool, arg1: &mut Player, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_random(arg0, arg2, arg3);
        arg0.total_amount = 0x1::vector::length<Fish>(&mut arg0.fishes);
        0x1::vector::push_back<Fish>(&mut arg1.store, 0x1::vector::swap_remove<Fish>(&mut arg0.fishes, v0));
    }

    public fun get_random(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::clock::timestamp_ms(arg1) % 0x1::vector::length<Fish>(&mut arg0.fishes)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id           : 0x2::object::new(arg0),
            fishes       : 0x1::vector::empty<Fish>(),
            total_amount : 0,
        };
        let v1 = Player{
            id    : 0x2::object::new(arg0),
            store : 0x1::vector::empty<Fish>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        0x2::transfer::transfer<Player>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

