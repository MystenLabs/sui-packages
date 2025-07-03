module 0x77045f1b9f811a7a8fb9ebd085b5b0c55c5cb0d1520ff55f7037f89b5da9f5f1::TBTC {
    struct MinterAdded has copy, drop {
        minter: address,
    }

    struct MinterRemoved has copy, drop {
        minter: address,
    }

    struct GuardianAdded has copy, drop {
        guardian: address,
    }

    struct GuardianRemoved has copy, drop {
        guardian: address,
    }

    struct Paused has copy, drop {
        guardian: address,
    }

    struct Unpaused has copy, drop {
        owner: address,
    }

    struct TokensMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
    }

    struct TBTC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        minter: address,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        guardian: address,
    }

    struct TokenState has store, key {
        id: 0x2::object::UID,
        minters: vector<address>,
        guardians: vector<address>,
        paused: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TBTC>, arg1: &TokenState, arg2: 0x2::coin::Coin<TBTC>) {
        assert!(!arg1.paused, 6);
        0x2::coin::burn<TBTC>(arg0, arg2);
        let v0 = TokensBurned{amount: 0x2::coin::value<TBTC>(&arg2)};
        0x2::event::emit<TokensBurned>(v0);
    }

    public entry fun mint(arg0: &MinterCap, arg1: &mut 0x2::coin::TreasuryCap<TBTC>, arg2: &TokenState, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.paused, 6);
        let v0 = 0x2::coin::mint<TBTC>(arg1, arg3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TBTC>>(v0, arg4);
        let v1 = TokensMinted{
            amount    : 0x2::coin::value<TBTC>(&v0),
            recipient : arg4,
        };
        0x2::event::emit<TokensMinted>(v1);
    }

    public entry fun add_guardian(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_guardian(arg1, arg2), 4);
        0x1::vector::push_back<address>(&mut arg1.guardians, arg2);
        let v0 = GuardianCap{
            id       : 0x2::object::new(arg3),
            guardian : arg2,
        };
        0x2::transfer::public_transfer<GuardianCap>(v0, arg2);
        let v1 = GuardianAdded{guardian: arg2};
        0x2::event::emit<GuardianAdded>(v1);
    }

    public fun add_minter_with_cap(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : MinterCap {
        assert!(!is_minter(arg1, arg2), 2);
        0x1::vector::push_back<address>(&mut arg1.minters, arg2);
        let v0 = MinterCap{
            id     : 0x2::object::new(arg3),
            minter : arg2,
        };
        let v1 = MinterAdded{minter: arg2};
        0x2::event::emit<MinterAdded>(v1);
        v0
    }

    public fun get_guardians(arg0: &TokenState) : vector<address> {
        arg0.guardians
    }

    public fun get_minters(arg0: &TokenState) : vector<address> {
        arg0.minters
    }

    fun init(arg0: TBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBTC>(arg0, 8, b"TBTC", b"tBTC v2", b"Canonical L2/sidechain token implementation for tBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/11224/standard/0x18084fba666a33d37592fa2633fd49a74dd93a88.png")), arg1);
        let v2 = TokenState{
            id        : 0x2::object::new(arg1),
            minters   : 0x1::vector::empty<address>(),
            guardians : 0x1::vector::empty<address>(),
            paused    : false,
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBTC>>(v0, v4);
        0x2::transfer::public_transfer<AdminCap>(v3, v4);
        0x2::transfer::share_object<TokenState>(v2);
    }

    public fun is_guardian(arg0: &TokenState, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.guardians, &arg1)
    }

    public fun is_minter(arg0: &TokenState, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.minters, &arg1)
    }

    public fun is_paused(arg0: &TokenState) : bool {
        arg0.paused
    }

    public entry fun pause(arg0: &GuardianCap, arg1: &mut TokenState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_guardian(arg1, v0), 1);
        assert!(!arg1.paused, 6);
        arg1.paused = true;
        let v1 = Paused{guardian: v0};
        0x2::event::emit<Paused>(v1);
    }

    public entry fun remove_guardian(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.guardians, &arg2);
        assert!(v0, 5);
        0x1::vector::remove<address>(&mut arg1.guardians, v1);
        let v2 = GuardianRemoved{guardian: arg2};
        0x2::event::emit<GuardianRemoved>(v2);
    }

    public entry fun remove_minter(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.minters, &arg2);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg1.minters, v1);
        let v2 = MinterRemoved{minter: arg2};
        0x2::event::emit<MinterRemoved>(v2);
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut TokenState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.paused, 7);
        arg1.paused = false;
        let v0 = Unpaused{owner: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Unpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

