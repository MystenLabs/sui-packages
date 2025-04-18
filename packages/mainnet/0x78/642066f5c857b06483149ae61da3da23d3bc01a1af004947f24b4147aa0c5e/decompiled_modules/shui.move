module 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    struct Global has key {
        id: 0x2::object::UID,
        supply: u64,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_SHUI: 0x2::balance::Balance<SHUI>,
        creator: address,
    }

    struct Inscription has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        gender: 0x1::string::String,
        avatar: 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::avatar::Avatar,
        race: 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::race::Race,
        level: 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::level::Level,
        gift: 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::gift::Gift,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHUI>, arg1: 0x2::coin::Coin<SHUI>) {
        0x2::coin::burn<SHUI>(arg0, arg1);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SHUI> {
        0x2::coin::mint<SHUI>(arg0, arg1, arg2)
    }

    public entry fun change_gift(arg0: &mut Inscription, arg1: 0x1::string::String) {
        arg0.gift = 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::gift::new_gift(arg1);
    }

    public(friend) fun extract_airdrop_balance(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 4);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, (450000000 + 250000000) * 1000000000)
    }

    public(friend) fun extract_founder_reserve_balance(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 4);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, 21000000 * 1000000000)
    }

    public(friend) fun extract_mission_reserve_balance(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 4);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, 229000000 * 1000000000)
    }

    public(friend) fun extract_swap_balance(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 4);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, 100000000 * 1000000000)
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 9, b"SHUI", b"SHUI", b"SHUI token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nftstorage.link/ipfs/bafybeieqqos2upvmmxzmauv6cf53ddegpjc5zkrvbpriz7iajamcxikv4y")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUI>>(v1);
        let v3 = Global{
            id           : 0x2::object::new(arg1),
            supply       : 2100000000,
            balance_SUI  : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_SHUI : 0x2::balance::zero<SHUI>(),
            creator      : 0x2::tx_context::sender(arg1),
        };
        let v4 = &mut v2;
        let v5 = mint(v4, 2100000000 * 1000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::balance::join<SHUI>(&mut v3.balance_SHUI, 0x2::coin::into_balance<SHUI>(v5));
        let v6 = &mut v3;
        transfer_to_reserve(v6, @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1000000000 * 1000000000, arg1);
        let v7 = &mut v3;
        transfer_to_reserve(v7, @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 50000000 * 1000000000, arg1);
        0x2::transfer::share_object<Global>(v3);
    }

    public fun new_empty_charactor(arg0: &mut 0x2::tx_context::TxContext) : Inscription {
        Inscription{
            id     : 0x2::object::new(arg0),
            name   : 0x1::string::utf8(b""),
            gender : 0x1::string::utf8(b""),
            avatar : 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::avatar::none(),
            race   : 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::race::none(),
            level  : 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::level::new_level(),
            gift   : 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::gift::none(),
        }
    }

    fun transfer_to_reserve(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHUI>>(0x2::coin::from_balance<SHUI>(0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, arg2), arg3), arg1);
    }

    public entry fun withdraw_shui(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHUI>>(0x2::coin::from_balance<SHUI>(0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_sui(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

