module 0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo {
    struct PBO has drop {
        dummy_field: bool,
    }

    struct TreasuryManagement has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PBO>,
    }

    struct Mint has copy, drop {
        amount: u64,
        minter: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut TreasuryManagement, arg1: 0x2::coin::Coin<PBO>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn{
            amount : 0x2::coin::burn<PBO>(&mut arg0.treasury_cap, arg1),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun mint(arg0: &mut TreasuryManagement, arg1: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg2: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PBO> {
        0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::check_role<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>(arg1, arg2);
        let v0 = Mint{
            amount : arg3,
            minter : 0x2::object::id_address<0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Mint>(v0);
        0x2::coin::mint<PBO>(&mut arg0.treasury_cap, arg3, arg4)
    }

    public fun total_supply(arg0: &TreasuryManagement) : u64 {
        0x2::coin::total_supply<PBO>(&arg0.treasury_cap)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<PBO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PBO>>(arg0, arg1);
    }

    fun init(arg0: PBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBO>(arg0, 8, b"PBD", b"Poseidollar Bond", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib3yyx7k35koqejjze2itb4tbdun73rxobrubuadpelw2f4hjaake")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBO>>(v1);
        let v2 = TreasuryManagement{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_share_object<TreasuryManagement>(v2);
    }

    public entry fun mint_and_transfer(arg0: &mut TreasuryManagement, arg1: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg2: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PBO>>(mint(arg0, arg1, arg2, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

