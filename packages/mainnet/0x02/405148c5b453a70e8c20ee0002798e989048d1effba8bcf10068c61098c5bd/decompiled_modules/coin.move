module 0x2405148c5b453a70e8c20ee0002798e989048d1effba8bcf10068c61098c5bd::coin {
    struct SupplyEvent has copy, drop {
        totalsupply: u64,
    }

    struct COIN has drop {
        dummy_field: bool,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<COIN>,
        CirculatingSupply: u64,
        DevAccount: address,
    }

    struct CmtyCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserTimestore has key {
        id: 0x2::object::UID,
        last_mint_time: u64,
        owner: address,
    }

    public entry fun MINT(arg0: &mut Treasury<COIN>, arg1: &mut UserTimestore, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 5);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(0x2::coin::total_supply<COIN>(&mut arg0.treasuryCap) + 4900 <= 1000000000, 3);
        assert!(v0 - arg1.last_mint_time >= 5, 1);
        arg1.last_mint_time = v0;
        0x2::coin::mint_and_transfer<COIN>(&mut arg0.treasuryCap, 4900, 0x2::tx_context::sender(arg3), arg3);
        0x2::coin::mint_and_transfer<COIN>(&mut arg0.treasuryCap, 100, arg0.DevAccount, arg3);
        arg0.CirculatingSupply = arg0.CirculatingSupply + 4900 + 100;
    }

    public entry fun create_timestore(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = UserTimestore{
            id             : 0x2::object::new(arg0),
            last_mint_time : 0,
            owner          : v0,
        };
        0x2::transfer::transfer<UserTimestore>(v1, v0);
    }

    public entry fun dev_mint_burn(arg0: &mut Treasury<COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.DevAccount, 1001);
        assert!(arg0.CirculatingSupply + arg1 <= 1000000000, 3);
        0x2::coin::mint_and_transfer<COIN>(&mut arg0.treasuryCap, arg1 * 100, arg0.DevAccount, arg2);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 2, b"NAILONG", b"NAILONG", b"I apply to join your life.fair mint MEMECOIN ON #SUI.", 0x1::option::some<0x2::url::Url>(0x2405148c5b453a70e8c20ee0002798e989048d1effba8bcf10068c61098c5bd::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        let v2 = Treasury<COIN>{
            id                : 0x2::object::new(arg1),
            treasuryCap       : v0,
            CirculatingSupply : 0,
            DevAccount        : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Treasury<COIN>>(v2);
        let v3 = CmtyCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CmtyCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_dev_account(arg0: &mut Treasury<COIN>, arg1: &CmtyCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.DevAccount = arg2;
    }

    // decompiled from Move bytecode v6
}

