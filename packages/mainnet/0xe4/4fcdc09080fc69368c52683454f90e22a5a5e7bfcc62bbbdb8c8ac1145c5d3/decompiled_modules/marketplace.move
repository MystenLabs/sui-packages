module 0xe44fcdc09080fc69368c52683454f90e22a5a5e7bfcc62bbbdb8c8ac1145c5d3::marketplace {
    struct Listing has store, key {
        id: 0x2::object::UID,
        marketplace_id: u8,
        category: u8,
        price: u64,
        quantity: u64,
        seller: address,
        description: vector<u8>,
    }

    struct ListingsByPrice<phantom T0, phantom T1> has copy, drop {
        marketplace_id: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<u8>,
        category: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<u8>,
        price: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<u64>,
        id: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<0x2::object::UID>,
    }

    struct ListingHistory<phantom T0, phantom T1> has copy, drop {
        marketplace_id: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<u8>,
        seller: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<address>,
        price: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<u64>,
        quantity: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<u64>,
    }

    struct TradeEvent has copy, drop {
        marketplace_id: u8,
        category: u8,
        price: u64,
        quantity: u64,
    }

    struct TradesByMarket<phantom T0, phantom T1> has copy, drop {
        marketplace_id: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<u8>,
        category: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<u8>,
        price: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<u64>,
        quantity: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<u64>,
    }

    struct LatestTradeByMarket<phantom T0, phantom T1> has copy, drop {
        marketplace_id: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<u8>,
        category: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Partition<u8>,
        price: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<u64>,
        quantity: 0x286bb770ee4d9e7e21020ba140debac108e4253235c9e9b7abe4f1c1ad0441c9::move_auto_index::Index<u64>,
    }

    public entry fun create_listing(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing{
            id             : 0x2::object::new(arg5),
            marketplace_id : arg0,
            category       : arg1,
            price          : arg2,
            quantity       : arg3,
            seller         : 0x2::tx_context::sender(arg5),
            description    : arg4,
        };
        0x2::transfer::transfer<Listing>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun delete_listing(arg0: Listing) {
        let Listing {
            id             : v0,
            marketplace_id : _,
            category       : _,
            price          : _,
            quantity       : _,
            seller         : _,
            description    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun execute_trade(arg0: u8, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = TradeEvent{
            marketplace_id : arg0,
            category       : arg1,
            price          : arg2,
            quantity       : arg3,
        };
        0x2::event::emit<TradeEvent>(v0);
    }

    public entry fun update_listing(arg0: &mut Listing, arg1: u64, arg2: u64) {
        arg0.price = arg1;
        arg0.quantity = arg2;
    }

    // decompiled from Move bytecode v6
}

