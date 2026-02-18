module 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn {
    struct TVYN has drop {
        dummy_field: bool,
    }

    struct Supply has key {
        id: 0x2::object::UID,
    }

    struct Created has store, key {
        id: 0x2::object::UID,
    }

    struct MintVault has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<TVYN>,
    }

    public(friend) fun borrow_cap_mut(arg0: &mut MintVault) : &mut 0x2::coin::TreasuryCap<TVYN> {
        &mut arg0.cap
    }

    public(friend) fun burn_for_protocol(arg0: &mut MintVault, arg1: 0x2::coin::Coin<TVYN>) {
        0x2::coin::burn<TVYN>(&mut arg0.cap, arg1);
    }

    public entry fun create_and_share_mint_vault(arg0: 0x2::coin::TreasuryCap<TVYN>, arg1: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintVault{
            id  : 0x2::object::new(arg2),
            cap : arg0,
        };
        0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::set_mint_vault_id(arg1, 0x2::object::id<MintVault>(&v0));
        0x2::transfer::share_object<MintVault>(v0);
    }

    fun create_currency_and_supply_internal(arg0: TVYN, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<0x2::url::Url>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVYN>(arg0, arg5, arg1, arg2, arg3, arg4, arg6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TVYN>>(v1);
        let v2 = Supply{id: 0x2::object::new(arg6)};
        0x2::transfer::share_object<Supply>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVYN>>(v0, 0x2::tx_context::sender(arg6));
        let v3 = Created{id: 0x2::object::new(arg6)};
        0x2::transfer::public_transfer<Created>(v3, 0x2::tx_context::sender(arg6));
    }

    fun init(arg0: TVYN, arg1: &mut 0x2::tx_context::TxContext) {
        create_currency_and_supply_internal(arg0, b"TimeVyn", b"TVYN", b"TimeVyn Protocol Token. A social protocol built on Proof of Lived Time. Visit https://timevyn.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://amethyst-high-woodpecker-414.mypinata.cloud/ipfs/bafybeihggdi6rcwwyhxmdld6g4zslwqwfstwdsgxo2oj2mk4yxddeejjty/tvyn-coin-logo.png")), 9, arg1);
    }

    public(friend) fun mint_for_protocol(arg0: &mut MintVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TVYN> {
        0x2::coin::mint<TVYN>(&mut arg0.cap, arg1, arg2)
    }

    public(friend) fun mint_for_reward(arg0: &mut MintVault, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TVYN>>(0x2::coin::mint<TVYN>(&mut arg0.cap, arg2, arg3), arg1);
        };
    }

    public(friend) fun mint_for_reward_to_user(arg0: &mut 0x2::coin::TreasuryCap<TVYN>, arg1: &mut Supply, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TVYN>>(0x2::coin::mint<TVYN>(arg0, arg3, arg4), arg2);
        };
    }

    public(friend) fun supply(arg0: &mut MintVault) : u64 {
        0x2::coin::total_supply<TVYN>(&arg0.cap)
    }

    public fun treasury_cap_type_id() : address {
        @0x2
    }

    // decompiled from Move bytecode v6
}

