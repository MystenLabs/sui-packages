module 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::game {
    struct PlayerParams has store, key {
        id: 0x2::object::UID,
        owner: address,
        stake_time: u64,
    }

    struct Game has key {
        id: 0x2::object::UID,
        owner: address,
        collector: address,
        verifier: vector<u8>,
    }

    struct ImportNftMessage has drop {
        prefix: vector<u8>,
        nft_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct PackMessage has drop {
        prefix: vector<u8>,
        token_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        pack_id: u8,
        game: address,
        owner: address,
        timestamp: u64,
    }

    struct CheckinMessage has drop {
        prefix: vector<u8>,
        owner: address,
        timestamp: u64,
    }

    struct SellPack has copy, drop {
        player: address,
        token_amount: u64,
        pack_id: u8,
    }

    struct BuyPack has copy, drop {
        player: address,
        token_amount: u64,
        pack_id: u8,
    }

    struct NftImported has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct NftExported has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct TransferOwnership has copy, drop {
        recepient: address,
    }

    struct SetCollector has copy, drop {
        recepient: address,
    }

    struct SetVerifier has copy, drop {
        recepient: vector<u8>,
    }

    struct Checkin has copy, drop {
        player: address,
        timestamp: u64,
    }

    public entry fun buy_pack<T0>(arg0: &mut Game, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = PackMessage{
            prefix       : b"buy_miner_pack",
            token_amount : v0,
            coin_type    : 0x1::type_name::get<T0>(),
            pack_id      : arg2,
            game         : 0x2::object::id_address<Game>(arg0),
            owner        : 0x2::tx_context::sender(arg5),
            timestamp    : arg3,
        };
        assert!(arg0.verifier == 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::verifier::ecrecover_to_eth_address(arg4, 0x2::bcs::to_bytes<PackMessage>(&v1)), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.collector);
        let v2 = BuyPack{
            player       : 0x2::tx_context::sender(arg5),
            token_amount : v0,
            pack_id      : arg2,
        };
        0x2::event::emit<BuyPack>(v2);
    }

    public entry fun checkin(arg0: &mut Game, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = CheckinMessage{
            prefix    : b"miner_checkin",
            owner     : v0,
            timestamp : arg1,
        };
        assert!(arg0.verifier == 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::verifier::ecrecover_to_eth_address(arg2, 0x2::bcs::to_bytes<CheckinMessage>(&v1)), 4);
        let v2 = Checkin{
            player    : v0,
            timestamp : arg1,
        };
        0x2::event::emit<Checkin>(v2);
    }

    fun export_nft<T0: store + key>(arg0: &mut Game, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, PlayerParams>(&arg0.id, arg1), 0);
        let PlayerParams {
            id         : v0,
            owner      : v1,
            stake_time : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, PlayerParams>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 1);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun export_nft_and_return<T0: store + key>(arg0: &mut Game, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = export_nft<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
        let v1 = NftExported{
            nft_id : arg1,
            owner  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NftExported>(v1);
    }

    public entry fun import_nft<T0: store + key>(arg0: &mut Game, arg1: T0, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = ImportNftMessage{
            prefix    : b"import_miner_nft",
            nft_id    : v0,
            owner     : v1,
            timestamp : arg2,
        };
        assert!(arg0.verifier == 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::verifier::ecrecover_to_eth_address(arg3, 0x2::bcs::to_bytes<ImportNftMessage>(&v2)), 4);
        let v3 = PlayerParams{
            id         : 0x2::object::new(arg4),
            owner      : v1,
            stake_time : arg2,
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v3.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, PlayerParams>(&mut arg0.id, v0, v3);
        let v4 = NftImported{
            nft_id : v0,
            owner  : v1,
        };
        0x2::event::emit<NftImported>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Game{
            id        : 0x2::object::new(arg0),
            owner     : v0,
            collector : v0,
            verifier  : x"3b1a85602794135bc124a5464c9989b888098777",
        };
        0x2::transfer::share_object<Game>(v1);
        let v2 = TransferOwnership{recepient: v0};
        0x2::event::emit<TransferOwnership>(v2);
        let v3 = SetCollector{recepient: v0};
        0x2::event::emit<SetCollector>(v3);
        let v4 = SetVerifier{recepient: x"3b1a85602794135bc124a5464c9989b888098777"};
        0x2::event::emit<SetVerifier>(v4);
    }

    public entry fun sell_pack<T0>(arg0: &mut Game, arg1: u64, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg0.collector;
        let v2 = PackMessage{
            prefix       : b"sell_miner_pack",
            token_amount : arg1,
            coin_type    : 0x1::type_name::get<T0>(),
            pack_id      : arg2,
            game         : 0x2::object::id_address<Game>(arg0),
            owner        : v0,
            timestamp    : arg3,
        };
        assert!(arg0.verifier == 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::verifier::ecrecover_to_eth_address(arg4, 0x2::bcs::to_bytes<PackMessage>(&v2)), 4);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v1), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<address, 0x2::coin::Coin<T0>>(&mut arg0.id, v1), arg1, arg5), v0);
        let v3 = SellPack{
            player       : v0,
            token_amount : arg1,
            pack_id      : arg2,
        };
        0x2::event::emit<SellPack>(v3);
    }

    public entry fun set_collector(arg0: &mut Game, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.collector = arg1;
        let v0 = SetCollector{recepient: arg1};
        0x2::event::emit<SetCollector>(v0);
    }

    public entry fun set_verifier(arg0: &mut Game, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.verifier = arg1;
        let v0 = SetVerifier{recepient: arg1};
        0x2::event::emit<SetVerifier>(v0);
    }

    public entry fun transfer_ownership(arg0: &mut Game, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
        let v0 = TransferOwnership{recepient: arg1};
        0x2::event::emit<TransferOwnership>(v0);
    }

    public entry fun transfer_token<T0>(arg0: &mut Game, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.collector, 1);
        if (0x2::dynamic_object_field::exists_with_type<address, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<address, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_object_field::add<address, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

