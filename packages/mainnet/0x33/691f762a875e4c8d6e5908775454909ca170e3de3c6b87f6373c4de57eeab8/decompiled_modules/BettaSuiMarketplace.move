module 0x33691f762a875e4c8d6e5908775454909ca170e3de3c6b87f6373c4de57eeab8::BettaSuiMarketplace {
    struct FeeTrading has store, key {
        id: 0x2::object::UID,
        fee: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        collection_name: 0x1::string::String,
        collection_id: 0x1::string::String,
        volume: u64,
        sale_count: u64,
    }

    struct ItemEvent has copy, drop {
        id: 0x2::object::ID,
        ask: u64,
        type: 0x1::string::String,
        owner: address,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        ask: u64,
        owner: address,
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(v1 <= 0x2::coin::value<0x2::sui::SUI>(&arg2), 0);
        arg0.volume = arg0.volume + v1;
        arg0.sale_count = arg0.sale_count + 1;
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, arg3 * v1 / 100, arg4), @0x667b5cd85f0ba5e05fdb056e35164d95dd1f1dba);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        let v5 = ItemEvent{
            id    : arg1,
            ask   : v1,
            type  : 0x1::string::utf8(b"buy"),
            owner : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ItemEvent>(v5);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun buy_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut FeeTrading, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy<T0>(arg0, arg1, arg2, arg3.fee, arg4);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun change_fee_trading(arg0: &mut FeeTrading, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x667b5cd85f0ba5e05fdb056e35164d95dd1f1dba, 2);
        arg0.fee = arg1;
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        let v4 = ItemEvent{
            id    : arg1,
            ask   : v1,
            type  : 0x1::string::utf8(b"delist"),
            owner : v2,
        };
        0x2::event::emit<ItemEvent>(v4);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun delist_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id              : 0x2::object::new(arg0),
            collection_name : 0x1::string::utf8(b"Betta Market"),
            collection_id   : 0x1::string::utf8(b""),
            volume          : 0,
            sale_count      : 0,
        };
        0x2::transfer::share_object<Marketplace>(v0);
        let v1 = FeeTrading{
            id  : 0x2::object::new(arg0),
            fee : 2,
        };
        0x2::transfer::share_object<FeeTrading>(v1);
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = Listing{
            id    : 0x2::object::new(arg3),
            ask   : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v1.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v0, v1);
        let v2 = ItemEvent{
            id    : v0,
            ask   : arg2,
            type  : 0x1::string::utf8(b"list"),
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ItemEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

