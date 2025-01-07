module 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo {
    struct PDO has drop {
        dummy_field: bool,
    }

    struct TreasuryManagement has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PDO>,
    }

    struct Mint has copy, drop {
        amount: u64,
        minter: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut TreasuryManagement, arg1: 0x2::coin::Coin<PDO>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn{
            amount : 0x2::coin::burn<PDO>(&mut arg0.treasury_cap, arg1),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun mint(arg0: &mut TreasuryManagement, arg1: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg2: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PDO> {
        0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::check_role<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>(arg1, arg2);
        let v0 = Mint{
            amount : arg3,
            minter : 0x2::object::id_address<0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Mint>(v0);
        0x2::coin::mint<PDO>(&mut arg0.treasury_cap, arg3, arg4)
    }

    public fun total_supply(arg0: &TreasuryManagement) : u64 {
        0x2::coin::total_supply<PDO>(&arg0.treasury_cap)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<PDO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PDO>>(arg0, arg1);
    }

    fun init(arg0: PDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDO>(arg0, 8, b"PDO", b"Poseidollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiapkqzmovj53bn3dnh53sdjaiitzdg7hoiq5y5fq42zier4ll44xq")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PDO>>(0x2::coin::mint<PDO>(&mut v2, 100000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = TreasuryManagement{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::public_share_object<TreasuryManagement>(v3);
    }

    public entry fun mint_and_transfer(arg0: &mut TreasuryManagement, arg1: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg2: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PDO>>(mint(arg0, arg1, arg2, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

