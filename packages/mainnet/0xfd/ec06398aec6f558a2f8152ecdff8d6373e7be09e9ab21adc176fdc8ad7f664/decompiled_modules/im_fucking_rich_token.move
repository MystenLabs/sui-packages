module 0xfdec06398aec6f558a2f8152ecdff8d6373e7be09e9ab21adc176fdc8ad7f664::im_fucking_rich_token {
    struct IM_FUCKING_RICH_TOKEN has drop {
        dummy_field: bool,
    }

    struct MintState has store, key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
        creator: address,
        dog: address,
        treasury_cap: 0x2::coin::TreasuryCap<IM_FUCKING_RICH_TOKEN>,
        paused: bool,
    }

    struct TokenMinted has copy, drop {
        number: u64,
        price: u64,
        minter: address,
    }

    struct MintingStatusChanged has copy, drop {
        paused: bool,
        changed_by: address,
    }

    fun current_price(arg0: u64) : u64 {
        let v0 = arg0 / 1000 + 1;
        if (v0 == 1) {
            return 100000000
        };
        if (v0 == 2) {
            return 250000000
        };
        if (v0 == 3) {
            return 500000000
        };
        if (v0 == 4) {
            return 1000000000
        };
        if (v0 == 5) {
            return 2000000000
        };
        if (v0 == 6) {
            return 4000000000
        };
        if (v0 == 7) {
            return 8000000000
        };
        if (v0 == 8) {
            return 16000000000
        };
        if (v0 == 9) {
            return 32000000000
        };
        if (v0 == 10) {
            return 64000000000
        };
        if (v0 == 11) {
            return 128000000000
        };
        if (v0 == 12) {
            return 200000000000
        };
        if (v0 == 13) {
            return 250000000000
        };
        if (v0 == 14) {
            return 300000000000
        };
        if (v0 == 15) {
            return 350000000000
        };
        if (v0 == 16) {
            return 420000000000
        };
        if (v0 == 17) {
            return 475000000000
        };
        if (v0 == 18) {
            return 550000000000
        };
        if (v0 == 19) {
            return 650000000000
        };
        if (v0 == 20) {
            return 800000000000
        };
        if (v0 == 21) {
            return 1000000000000
        };
        if (v0 == 22) {
            return 1000000000000
        };
        1000000000000
    }

    public fun get_current_price(arg0: &MintState) : u64 {
        current_price(arg0.total_minted)
    }

    public fun get_current_tier_end(arg0: u64) : u64 {
        (arg0 / 1000 + 1) * 1000
    }

    public fun get_remaining_in_tier(arg0: u64) : u64 {
        get_current_tier_end(arg0) - arg0
    }

    public fun get_state(arg0: &MintState) : (u64, u64, u64, u64, u64, u64, bool) {
        let v0 = arg0.total_minted;
        let v1 = arg0.max_supply;
        (v0, current_price(v0), get_current_tier_end(v0), get_remaining_in_tier(v0), v1, v1 - v0, arg0.paused)
    }

    fun init(arg0: IM_FUCKING_RICH_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad;
        let v1 = @0x79bb8cc3945d918e5870b8cfcda8c86f835fa9463a044b917ea519fe518fdebf;
        let (v2, v3) = 0x2::coin::create_currency<IM_FUCKING_RICH_TOKEN>(arg0, 9, b"WOW", b"I'M SO FUCKING RICH", b"https://imsofuckingrich.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imsofuckingrich.com/crown-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IM_FUCKING_RICH_TOKEN>>(v3);
        let v4 = MintState{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            max_supply   : 21000,
            creator      : v0,
            dog          : v1,
            treasury_cap : v2,
            paused       : false,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<IM_FUCKING_RICH_TOKEN>>(0x2::coin::mint<IM_FUCKING_RICH_TOKEN>(&mut v4.treasury_cap, 1000 * 1000000000, arg1), v0);
        v4.total_minted = v4.total_minted + 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<IM_FUCKING_RICH_TOKEN>>(0x2::coin::mint<IM_FUCKING_RICH_TOKEN>(&mut v4.treasury_cap, 500 * 1000000000, arg1), v1);
        v4.total_minted = v4.total_minted + 500;
        let v5 = TokenMinted{
            number : v4.total_minted,
            price  : 0,
            minter : @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad,
        };
        0x2::event::emit<TokenMinted>(v5);
        0x2::transfer::share_object<MintState>(v4);
    }

    public fun is_minting_paused(arg0: &MintState) : bool {
        arg0.paused
    }

    public fun mint_token(arg0: &mut MintState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        let v0 = arg0.total_minted;
        let v1 = current_price(v0);
        let v2 = get_remaining_in_tier(v0);
        assert!(v0 < 21000, 1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v3 >= v1, 0);
        assert!(v3 <= v1 * v2, 2);
        assert!(v3 % v1 == 0, 2);
        let v4 = v3 / v1;
        let v5 = v4;
        if (v4 > v2) {
            v5 = v2;
        };
        if (v5 > 21000 - v0) {
            v5 = 21000 - v0;
        };
        assert!(v5 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.dog);
        arg0.total_minted = arg0.total_minted + v5;
        let v6 = TokenMinted{
            number : arg0.total_minted,
            price  : v1,
            minter : arg2,
        };
        0x2::event::emit<TokenMinted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<IM_FUCKING_RICH_TOKEN>>(0x2::coin::mint<IM_FUCKING_RICH_TOKEN>(&mut arg0.treasury_cap, v5 * 1000000000, arg3), arg2);
    }

    public entry fun toggle_minting(arg0: &mut MintState, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 5);
        arg0.paused = arg1;
        let v0 = MintingStatusChanged{
            paused     : arg1,
            changed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MintingStatusChanged>(v0);
    }

    public entry fun update_dog_address(arg0: &mut MintState, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 5);
        arg0.dog = arg1;
    }

    // decompiled from Move bytecode v6
}

