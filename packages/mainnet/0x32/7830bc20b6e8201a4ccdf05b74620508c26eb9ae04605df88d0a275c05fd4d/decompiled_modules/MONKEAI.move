module 0x327830bc20b6e8201a4ccdf05b74620508c26eb9ae04605df88d0a275c05fd4d::MONKEAI {
    struct MONKEAI has drop {
        dummy_field: bool,
    }

    struct Airdrop<phantom T0> has key {
        id: 0x2::object::UID,
        total_amount: u64,
        total_claim: u64,
        balance: 0x2::balance::Balance<T0>,
        claimed_address: 0x2::table::Table<address, bool>,
        eligble_address: 0x2::table::Table<address, u64>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MONKEAI>, arg1: 0x2::coin::Coin<MONKEAI>) {
        0x2::coin::burn<MONKEAI>(arg0, arg1);
    }

    public entry fun add_whitelist(arg0: &mut 0x2::coin::TreasuryCap<MONKEAI>, arg1: &mut Airdrop<MONKEAI>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, u64>(&arg1.eligble_address, arg2)) {
            0x2::table::add<address, u64>(&mut arg1.eligble_address, arg2, arg3);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.eligble_address, arg2);
            *v0 = *v0 + 1;
        };
    }

    public entry fun add_whitelist_bulk(arg0: &mut 0x2::coin::TreasuryCap<MONKEAI>, arg1: &mut Airdrop<MONKEAI>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            add_whitelist(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), *0x1::vector::borrow<u64>(&arg3, v0), arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun claim(arg0: &mut Airdrop<MONKEAI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.eligble_address, v0), 3);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed_address, v0), 0);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.eligble_address, v0);
        assert!(0x2::balance::value<MONKEAI>(&arg0.balance) >= v1, 2);
        arg0.total_claim = arg0.total_claim + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<MONKEAI>>(0x2::coin::take<MONKEAI>(&mut arg0.balance, v1, arg1), v0);
        0x2::table::add<address, bool>(&mut arg0.claimed_address, v0, true);
    }

    public entry fun deecrease_airdrop(arg0: &mut 0x2::coin::TreasuryCap<MONKEAI>, arg1: &mut Airdrop<MONKEAI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<MONKEAI>(&arg1.balance) >= arg2, 2);
        0x2::coin::burn<MONKEAI>(arg0, 0x2::coin::take<MONKEAI>(&mut arg1.balance, arg2, arg3));
        arg1.total_amount = arg1.total_amount - arg2;
    }

    public entry fun increase_airdrop(arg0: &mut 0x2::coin::TreasuryCap<MONKEAI>, arg1: &mut Airdrop<MONKEAI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<MONKEAI>(&mut arg1.balance, 0x2::coin::mint_balance<MONKEAI>(arg0, arg2));
        arg1.total_amount = arg1.total_amount + arg2;
    }

    fun init(arg0: MONKEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEAI>(arg0, 9, b"MONKEAI", b"MONKEAI", b"$MONKEAI serve as the native currency within the blockchain platform, it is used to access certain features or services within the network, or to participate in decentralized applications built on the platform: Staking, Yield Farming and Holders Reward", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiex2o5usgiu6esbhl5jq7gzzviqtrsjiosqxed6slhotilaj4w4ii.ipfs.nftstorage.link/MonkeAI.png")), arg1);
        let v2 = Airdrop<MONKEAI>{
            id              : 0x2::object::new(arg1),
            total_amount    : 0,
            total_claim     : 0,
            balance         : 0x2::balance::zero<MONKEAI>(),
            claimed_address : 0x2::table::new<address, bool>(arg1),
            eligble_address : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<Airdrop<MONKEAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MONKEAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MONKEAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

