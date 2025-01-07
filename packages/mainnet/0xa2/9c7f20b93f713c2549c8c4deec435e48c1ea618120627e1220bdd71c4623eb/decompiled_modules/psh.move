module 0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh {
    struct PSH has drop {
        dummy_field: bool,
    }

    struct TreasuryManagement has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PSH>,
    }

    struct Mint has copy, drop {
        amount: u64,
        minter: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut TreasuryManagement, arg1: 0x2::coin::Coin<PSH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn{
            amount : 0x2::coin::burn<PSH>(&mut arg0.treasury_cap, arg1),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun mint(arg0: &mut TreasuryManagement, arg1: &0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::Role<0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh_minter_role::PSH_MINTER_ROLE>, arg2: &0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::Member<0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh_minter_role::PSH_MINTER_ROLE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PSH> {
        0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::check_role<0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh_minter_role::PSH_MINTER_ROLE>(arg1, arg2);
        let v0 = Mint{
            amount : arg3,
            minter : 0x2::object::id_address<0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::Member<0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh_minter_role::PSH_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Mint>(v0);
        0x2::coin::mint<PSH>(&mut arg0.treasury_cap, arg3, arg4)
    }

    public fun total_supply(arg0: &TreasuryManagement) : u64 {
        0x2::coin::total_supply<PSH>(&arg0.treasury_cap)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<PSH>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PSH>>(arg0, arg1);
    }

    fun init(arg0: PSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSH>(arg0, 8, b"PSH", b"Poseidollar Shares", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreighu6ns5ewscolbg7y47ohzw3llf6yoqaz7z6wbil6qpwoyo5o5bq")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PSH>>(0x2::coin::mint<PSH>(&mut v2, 10000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = TreasuryManagement{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::public_share_object<TreasuryManagement>(v3);
    }

    public entry fun mint_and_transfer(arg0: &mut TreasuryManagement, arg1: &0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::Role<0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh_minter_role::PSH_MINTER_ROLE>, arg2: &0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::Member<0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh_minter_role::PSH_MINTER_ROLE>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PSH>>(mint(arg0, arg1, arg2, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

