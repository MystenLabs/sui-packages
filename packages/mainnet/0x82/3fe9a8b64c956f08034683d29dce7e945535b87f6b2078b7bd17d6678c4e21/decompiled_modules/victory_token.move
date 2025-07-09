module 0x823fe9a8b64c956f08034683d29dce7e945535b87f6b2078b7bd17d6678c4e21::victory_token {
    struct VICTORY_TOKEN has drop {
        dummy_field: bool,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
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

    fun init(arg0: VICTORY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VICTORY_TOKEN>(arg0, 6, b"VICTORY", b"Victory Token", b"Reward token for Suitrump Farm", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryCapWrapper{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapWrapper>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICTORY_TOKEN>>(v1);
        let v3 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MinterCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun mint_for_farm(arg0: &mut TreasuryCapWrapper, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VICTORY_TOKEN>>(0x2::coin::mint<VICTORY_TOKEN>(&mut arg0.cap, arg1, arg3), arg2);
        let v0 = VictoryMinted{
            amount    : (arg1 as u256),
            recipient : arg2,
        };
        0x2::event::emit<VictoryMinted>(v0);
    }

    public entry fun transfer_minter_cap(arg0: MinterCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<MinterCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

