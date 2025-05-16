module 0x3153e46a072498d696b0423c7d13572fda40e7e812ef50b4c056c2134ffb017a::HetraCoin {
    struct HETRACOIN has drop {
        dummy_field: bool,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        timestamp: u64,
    }

    struct AdminChangeEvent has copy, drop {
        previous_admin: address,
        new_admin: address,
        timestamp: u64,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct EmergencyPauseState has store, key {
        id: 0x2::object::UID,
        paused: bool,
        pause_reason: vector<u8>,
        paused_at: u64,
        paused_by: address,
        last_updated: u64,
    }

    struct EmergencyPauseEvent has copy, drop {
        paused: bool,
        admin: address,
        timestamp: u64,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HETRACOIN>, arg1: &EmergencyPauseState, arg2: 0x2::coin::Coin<HETRACOIN>) {
        assert!(!arg1.paused, 104);
        0x2::coin::burn<HETRACOIN>(arg0, arg2);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HETRACOIN>, arg1: u64, arg2: &AdminRegistry, arg3: &EmergencyPauseState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HETRACOIN> {
        assert!(0x2::tx_context::sender(arg4) == arg2.admin, 101);
        assert!(!arg3.paused, 104);
        assert!(0x2::coin::total_supply<HETRACOIN>(arg0) + arg1 <= 1000000000000000000, 106);
        0x2::coin::mint<HETRACOIN>(arg0, arg1, arg4)
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<HETRACOIN>) : u64 {
        0x2::coin::total_supply<HETRACOIN>(arg0)
    }

    public fun change_admin(arg0: &0x2::coin::TreasuryCap<HETRACOIN>, arg1: &AdminCap, arg2: &mut AdminRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2.admin, 101);
        arg2.admin = arg3;
        let v0 = AdminChangeEvent{
            previous_admin : arg2.admin,
            new_admin      : arg3,
            timestamp      : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AdminChangeEvent>(v0);
    }

    fun create_currency_internal(arg0: HETRACOIN, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<HETRACOIN>, 0x2::coin::CoinMetadata<HETRACOIN>) {
        0x2::coin::create_currency<HETRACOIN>(arg0, 9, b"HETRA", b"HetraCoin", b"Decentralized gaming token for HetraFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cyan-careful-badger-476.mypinata.cloud/ipfs/bafkreic3li5r3gt3wqrbkepq23ru5nckeoxfpbzelondeix3usfdvqmbii")), arg1)
    }

    public fun governance_admin(arg0: &AdminRegistry) : address {
        arg0.admin
    }

    fun init(arg0: HETRACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_currency_internal(arg0, arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = AdminRegistry{
            id    : 0x2::object::new(arg1),
            admin : v2,
        };
        let v5 = EmergencyPauseState{
            id           : 0x2::object::new(arg1),
            paused       : false,
            pause_reason : b"",
            paused_at    : 0,
            paused_by    : @0x0,
            last_updated : 0x2::tx_context::epoch(arg1),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HETRACOIN>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HETRACOIN>>(v1, v2);
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
        0x2::transfer::share_object<AdminRegistry>(v4);
        0x2::transfer::share_object<EmergencyPauseState>(v5);
        let v6 = SetupCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SetupCap>(v6, v2);
    }

    public fun is_paused(arg0: &EmergencyPauseState) : bool {
        arg0.paused
    }

    public entry fun pause(arg0: &mut EmergencyPauseState, arg1: &AdminRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 101);
        arg0.paused = !arg0.paused;
        let v0 = EmergencyPauseEvent{
            paused    : arg0.paused,
            admin     : arg1.admin,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public entry fun pause_operations(arg0: &AdminRegistry, arg1: &mut EmergencyPauseState, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 101);
        arg1.paused = true;
        arg1.pause_reason = arg2;
        arg1.paused_at = 0x2::tx_context::epoch(arg3);
        arg1.paused_by = 0x2::tx_context::sender(arg3);
        arg1.last_updated = 0x2::tx_context::epoch(arg3);
        let v0 = EmergencyPauseEvent{
            paused    : true,
            admin     : arg0.admin,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public fun pause_reason(arg0: &EmergencyPauseState) : vector<u8> {
        arg0.pause_reason
    }

    public entry fun secure_transfer(arg0: &mut 0x2::coin::Coin<HETRACOIN>, arg1: address, arg2: u64, arg3: &EmergencyPauseState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.paused, 104);
        assert!(arg2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HETRACOIN>>(0x2::coin::split<HETRACOIN>(arg0, arg2, arg4), arg1);
        let v0 = TransferEvent{
            from      : 0x2::tx_context::sender(arg4),
            to        : arg1,
            amount    : arg2,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public entry fun setup_for_testnet(arg0: SetupCap, arg1: &mut 0x2::tx_context::TxContext) {
        let SetupCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun unpause_operations(arg0: &AdminRegistry, arg1: &mut EmergencyPauseState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 101);
        assert!(arg1.paused, 105);
        arg1.paused = false;
        arg1.pause_reason = b"";
        arg1.last_updated = 0x2::tx_context::epoch(arg2);
        let v0 = EmergencyPauseEvent{
            paused    : false,
            admin     : arg0.admin,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

