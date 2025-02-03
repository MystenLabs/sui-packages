module 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    struct Global has key {
        id: 0x2::object::UID,
        supply: u64,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_SHUI: 0x2::balance::Balance<SHUI>,
        creator: address,
        version: u64,
    }

    struct Inscription has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        gender: 0x1::string::String,
        avatar: 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::avatar::Avatar,
        race: 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::race::Race,
        level: 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::level::Level,
        gift: 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::gift::Gift,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHUI>, arg1: 0x2::coin::Coin<SHUI>) {
        0x2::coin::burn<SHUI>(arg0, arg1);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SHUI> {
        0x2::coin::mint<SHUI>(arg0, arg1, arg2)
    }

    public entry fun change_gift(arg0: &mut Inscription, arg1: 0x1::string::String) {
        arg0.gift = 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::gift::new_gift(arg1);
    }

    public fun change_owner(arg0: &mut Global, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.creator = arg1;
    }

    public(friend) fun extract_airdrop_balance(arg0: &mut Global, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, (450000000 + 320000000) * 1000000000)
    }

    public(friend) fun extract_founder_reserve_balance(arg0: &mut Global, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, 21000000 * 1000000000)
    }

    public(friend) fun extract_mission_reserve_balance(arg0: &mut Global, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, 159000000 * 1000000000)
    }

    public(friend) fun extract_swap_balance(arg0: &mut Global, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<SHUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, 100000000 * 1000000000)
    }

    public fun increment(arg0: &mut Global, arg1: u64) {
        assert!(arg0.version == 0, 2);
        arg0.version = arg1;
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
            version      : 0,
        };
        let v4 = &mut v2;
        let v5 = mint(v4, 2100000000 * 1000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::balance::join<SHUI>(&mut v3.balance_SHUI, 0x2::coin::into_balance<SHUI>(v5));
        let v6 = &mut v3;
        transfer_to_reserve(v6, @0x800ad2d2649ce4ec148a2c90a67136780fd3c8c3a915831852903b40d1197a09, 1000000000 * 1000000000, arg1);
        let v7 = &mut v3;
        transfer_to_reserve(v7, @0x800ad2d2649ce4ec148a2c90a67136780fd3c8c3a915831852903b40d1197a09, 50000000 * 1000000000, arg1);
        0x2::transfer::share_object<Global>(v3);
    }

    public fun new_empty_charactor(arg0: &mut 0x2::tx_context::TxContext) : Inscription {
        Inscription{
            id     : 0x2::object::new(arg0),
            name   : 0x1::string::utf8(b""),
            gender : 0x1::string::utf8(b""),
            avatar : 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::avatar::none(),
            race   : 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::race::none(),
            level  : 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::level::new_level(),
            gift   : 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::gift::none(),
        }
    }

    fun transfer_to_reserve(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHUI>>(0x2::coin::from_balance<SHUI>(0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, arg2), arg3), arg1);
    }

    public entry fun withdraw_shui(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHUI>>(0x2::coin::from_balance<SHUI>(0x2::balance::split<SHUI>(&mut arg0.balance_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_sui(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

