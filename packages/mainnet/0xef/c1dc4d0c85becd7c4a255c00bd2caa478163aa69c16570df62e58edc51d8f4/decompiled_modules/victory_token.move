module 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::victory_token {
    struct VICTORY_TOKEN has drop {
        dummy_field: bool,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct TreasuryCapWrapper has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<VICTORY_TOKEN>,
    }

    struct VictoryMinted has copy, drop {
        amount: u256,
        recipient: address,
    }

    struct VictoryBurned has copy, drop {
        amount: u256,
    }

    public entry fun burn(arg0: &mut TreasuryCapWrapper, arg1: 0x2::coin::Coin<VICTORY_TOKEN>) {
        0x2::coin::burn<VICTORY_TOKEN>(&mut arg0.cap, arg1);
        let v0 = VictoryBurned{amount: (0x2::coin::value<VICTORY_TOKEN>(&arg1) as u256)};
        0x2::event::emit<VictoryBurned>(v0);
    }

    public entry fun mint(arg0: &mut TreasuryCapWrapper, arg1: u64, arg2: address, arg3: &MinterCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg3.admin, 1);
        assert!(0x2::coin::total_supply<VICTORY_TOKEN>(&arg0.cap) + arg1 <= 500000000000000, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<VICTORY_TOKEN>>(0x2::coin::mint<VICTORY_TOKEN>(&mut arg0.cap, arg1, arg4), arg2);
        let v0 = VictoryMinted{
            amount    : (arg1 as u256),
            recipient : arg2,
        };
        0x2::event::emit<VictoryMinted>(v0);
    }

    public fun get_metadata_info(arg0: &0x2::coin::CoinMetadata<VICTORY_TOKEN>) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8) {
        (0x2::coin::get_name<VICTORY_TOKEN>(arg0), 0x1::string::utf8(0x1::ascii::into_bytes(0x2::coin::get_symbol<VICTORY_TOKEN>(arg0))), 0x2::coin::get_description<VICTORY_TOKEN>(arg0), 0x2::coin::get_decimals<VICTORY_TOKEN>(arg0))
    }

    public fun get_supply_info(arg0: &TreasuryCapWrapper) : (u64, u64) {
        let v0 = 0x2::coin::total_supply<VICTORY_TOKEN>(&arg0.cap);
        (v0, 500000000000000 - v0)
    }

    fun init(arg0: VICTORY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VICTORY_TOKEN>(arg0, 6, b"TVIC", b"TVIC", b"TVIC token for Suitrump Farm - Max Supply: 500M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptomischief.mypinata.cloud/ipfs/bafybeid2ef3p7qxc3znj5ztbkmidfmbgb43dzclc6c2qyjfqfi5jr65nnm/Victory.png")), arg1);
        let v3 = TreasuryCapWrapper{
            id  : 0x2::object::new(arg1),
            cap : v1,
        };
        0x2::transfer::share_object<TreasuryCapWrapper>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICTORY_TOKEN>>(v2);
        let v4 = MinterCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<MinterCap>(v4, v0);
    }

    // decompiled from Move bytecode v6
}

