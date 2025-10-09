module 0x7c0d55e577745df48045d5512fe07d0b5fe34ebfd365558fee25211af08ba71c::diamonds {
    struct DIAMONDS has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<DIAMONDS>,
        owner: address,
        paused: bool,
    }

    struct StateChanged has copy, drop, store {
        state: bool,
    }

    struct Deposited has copy, drop, store {
        amount: u64,
        total: u64,
    }

    struct Spent has copy, drop, store {
        total: u64,
    }

    struct OwnerChanged has copy, drop, store {
        previous: address,
        current: address,
    }

    public fun spend(arg0: &mut Store, arg1: 0x2::token::Token<DIAMONDS>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 77);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 99);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<DIAMONDS>(&mut arg0.treasury, 0x2::token::spend<DIAMONDS>(arg1, arg2), arg2);
        let v4 = Spent{total: 0x2::token::value<DIAMONDS>(&arg1)};
        0x2::event::emit<Spent>(v4);
    }

    public fun create(arg0: &mut Store, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 77);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 99);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<DIAMONDS>(&mut arg0.treasury, 0x2::token::transfer<DIAMONDS>(0x2::token::mint<DIAMONDS>(&mut arg0.treasury, arg1, arg2), arg0.owner, arg2), arg2);
        let v4 = Deposited{
            amount : arg1,
            total  : arg1,
        };
        0x2::event::emit<Deposited>(v4);
    }

    public fun deposit(arg0: &mut Store, arg1: 0x2::token::Token<DIAMONDS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 77);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 99);
        0x2::token::join<DIAMONDS>(&mut arg1, 0x2::token::mint<DIAMONDS>(&mut arg0.treasury, arg2, arg3));
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<DIAMONDS>(&mut arg0.treasury, 0x2::token::transfer<DIAMONDS>(arg1, arg0.owner, arg3), arg3);
        let v4 = Deposited{
            amount : arg2,
            total  : arg2 + 0x2::token::value<DIAMONDS>(&arg1),
        };
        0x2::event::emit<Deposited>(v4);
    }

    fun init(arg0: DIAMONDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMONDS>(arg0, 0, b"DIAMONDS", b"Lineup Games Diamonds", x"537461636b204469616d6f6e647320746f20626f6f737420796f757220736861726520e280942061206d6173736976652061697264726f70206973206f6e20746865207761792e20546865206d6f726520796f752073636f72652c20746865206d6f726520796f75206561726e2e20506c617920736d6172742c20636f6c6c65637420686172642c20616e642077696e206269672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.unkjd.games/metadata/diamond_season_1.png")), arg1);
        let v2 = Store{
            id       : 0x2::object::new(arg1),
            treasury : v0,
            owner    : 0x2::tx_context::sender(arg1),
            paused   : false,
        };
        0x2::transfer::share_object<Store>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMONDS>>(v1);
    }

    public fun pause(arg0: &mut Store, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 99);
        arg0.paused = arg1;
        let v0 = StateChanged{state: arg1};
        0x2::event::emit<StateChanged>(v0);
    }

    public fun transfer_ownership(arg0: &mut Store, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 99);
        arg0.owner = arg1;
        let v0 = OwnerChanged{
            previous : arg0.owner,
            current  : arg1,
        };
        0x2::event::emit<OwnerChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

