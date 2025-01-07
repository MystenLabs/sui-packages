module 0xb85d3853c7a33cf6cc243d5ae748b3a85ccc0ea2142db680aeedfa079b19fe13::tikcoin {
    struct SupplyEvent has copy, drop {
        totalsupply: u64,
    }

    struct TIKCOIN has drop {
        dummy_field: bool,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<TIKCOIN>,
        CirculatingSupply: u128,
        CmtyAccount: address,
    }

    struct CmtyCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun claim(arg0: &mut Treasury<TIKCOIN>, arg1: &mut 0xb85d3853c7a33cf6cc243d5ae748b3a85ccc0ea2142db680aeedfa079b19fe13::mine::Miner, arg2: &0xb85d3853c7a33cf6cc243d5ae748b3a85ccc0ea2142db680aeedfa079b19fe13::mine::Epochs, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb85d3853c7a33cf6cc243d5ae748b3a85ccc0ea2142db680aeedfa079b19fe13::mine::claim(arg1, arg2, arg3, arg4);
        if (v0 > 0) {
            let v1 = v0 * 1 / 100;
            0x2::coin::mint_and_transfer<TIKCOIN>(&mut arg0.treasuryCap, ((v0 - v1) as u64), 0x2::tx_context::sender(arg4), arg4);
            0x2::coin::mint_and_transfer<TIKCOIN>(&mut arg0.treasuryCap, (v1 as u64), arg0.CmtyAccount, arg4);
            arg0.CirculatingSupply = arg0.CirculatingSupply + v0;
        };
    }

    fun init(arg0: TIKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKCOIN>(arg0, 12, b"TIK", b"TIKCOIN", b"Time Flies, TIK Stays! Everyone Gets a Fair Chance to Mine and Earn Rewards!", 0x1::option::some<0x2::url::Url>(0xb85d3853c7a33cf6cc243d5ae748b3a85ccc0ea2142db680aeedfa079b19fe13::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKCOIN>>(v1);
        let v2 = Treasury<TIKCOIN>{
            id                : 0x2::object::new(arg1),
            treasuryCap       : v0,
            CirculatingSupply : 0,
            CmtyAccount       : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Treasury<TIKCOIN>>(v2);
        let v3 = CmtyCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CmtyCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_community_account(arg0: &mut Treasury<TIKCOIN>, arg1: &CmtyCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.CmtyAccount = arg2;
    }

    public entry fun show_total_supply(arg0: &Treasury<TIKCOIN>) : u64 {
        let v0 = 0x2::coin::total_supply<TIKCOIN>(&arg0.treasuryCap);
        let v1 = SupplyEvent{totalsupply: v0};
        0x2::event::emit<SupplyEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

