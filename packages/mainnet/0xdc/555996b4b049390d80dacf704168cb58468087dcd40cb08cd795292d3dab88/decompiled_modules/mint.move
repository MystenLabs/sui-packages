module 0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::mint {
    struct BlubWhitelistTicket has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionData has store, key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>,
        registry: 0x2::table::Table<address, u64>,
        mint_wl_date: u64,
        mint_buy_date: u64,
        mint_buy_price: u64,
    }

    public entry fun mint(arg0: BlubWhitelistTicket, arg1: 0x2::coin::Coin<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>, arg2: &mut CollectionData, arg3: &0x2::transfer_policy::TransferPolicy<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNft>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.mint_wl_date, 9223372350387388415);
        assert!(arg2.mint_buy_price <= 0x2::coin::value<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>(&arg1), 9223372358977323007);
        if (0x2::table::contains<address, u64>(&arg2.registry, 0x2::tx_context::sender(arg7))) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg2.registry, 0x2::tx_context::sender(arg7));
            assert!(*v0 < 10, 0);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg2.registry, 0x2::tx_context::sender(arg7), 1);
        };
        let BlubWhitelistTicket { id: v1 } = arg0;
        0x2::object::delete(v1);
        let v2 = if (0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg2.nfts) == 1) {
            0
        } else {
            0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::pseuso_random::rng(0, 0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg2.nfts) - 1, arg4, arg7)
        };
        let v3 = if (0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg2.nfts) == 1) {
            0x2::table_vec::pop_back<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&mut arg2.nfts)
        } else {
            0x2::table_vec::swap_remove<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&mut arg2.nfts, v2)
        };
        0x2::kiosk::lock<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNft>(arg5, arg6, arg3, 0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::mint(v3, arg1, arg7));
    }

    public fun change_mint_buy_date(arg0: &0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::cap::MintCap, arg1: &mut CollectionData, arg2: u64) {
        arg1.mint_buy_date = arg2;
    }

    public fun change_mint_wl_date(arg0: &0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::cap::MintCap, arg1: &mut CollectionData, arg2: u64) {
        arg1.mint_wl_date = arg2;
    }

    public fun create_data(arg0: &0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::cap::MintCap, arg1: &mut CollectionData, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut vector<0x1::string::String>, arg5: &mut vector<0x1::string::String>) {
        0x2::table_vec::push_back<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&mut arg1.nfts, 0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::create(arg2, arg3, arg4, arg5));
    }

    public fun distribute_wl(arg0: &0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::cap::MintCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = BlubWhitelistTicket{id: 0x2::object::new(arg2)};
            0x2::transfer::public_transfer<BlubWhitelistTicket>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionData{
            id             : 0x2::object::new(arg0),
            nfts           : 0x2::table_vec::empty<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(arg0),
            registry       : 0x2::table::new<address, u64>(arg0),
            mint_wl_date   : 1728759600000,
            mint_buy_date  : 1728846000000,
            mint_buy_price : 500000000000,
        };
        0x2::transfer::public_share_object<CollectionData>(v0);
    }

    public entry fun mint_buy(arg0: 0x2::coin::Coin<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>, arg1: &mut CollectionData, arg2: &0x2::transfer_policy::TransferPolicy<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNft>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.mint_buy_date, 9223372526481047551);
        assert!(arg1.mint_buy_price <= 0x2::coin::value<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>(&arg0), 9223372535070982143);
        if (0x2::table::contains<address, u64>(&arg1.registry, 0x2::tx_context::sender(arg6))) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.registry, 0x2::tx_context::sender(arg6));
            assert!(*v0 < 10, 0);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.registry, 0x2::tx_context::sender(arg6), 1);
        };
        let v1 = if (0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg1.nfts) == 1) {
            0
        } else {
            0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::pseuso_random::rng(0, 0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg1.nfts) - 1, arg3, arg6)
        };
        let v2 = if (0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg1.nfts) == 1) {
            0x2::table_vec::pop_back<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&mut arg1.nfts)
        } else {
            0x2::table_vec::swap_remove<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&mut arg1.nfts, v1)
        };
        0x2::kiosk::lock<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNft>(arg4, arg5, arg2, 0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::mint(v2, arg0, arg6));
    }

    public fun mint_rest(arg0: &0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::cap::MintCap, arg1: &mut CollectionData, arg2: &0x2::transfer_policy::TransferPolicy<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNft>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg1.nfts) > 0, 9223372848603594751);
        assert!(arg1.mint_buy_price * 0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg1.nfts) <= 0x2::coin::value<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>(&arg5), 9223372857193529343);
        while (0x2::table_vec::length<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&arg1.nfts) > 0) {
            0x2::kiosk::lock<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNft>(arg3, arg4, arg2, 0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::mint(0x2::table_vec::pop_back<0xdc555996b4b049390d80dacf704168cb58468087dcd40cb08cd795292d3dab88::collection::BabyBlubNftData>(&mut arg1.nfts), 0x2::coin::split<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>(&mut arg5, arg1.mint_buy_price, arg6), arg6));
        };
        0x2::coin::destroy_zero<0xecdc81bd6e5a1b889d428d19c7949ff45708045d445c9f937c51e25bb85e39d0::bb::BB>(arg5);
    }

    // decompiled from Move bytecode v6
}

