module 0x664573bb7cca42dede8ee7121af1788ae3ab6155bbe07e57483665d9a892bbe4::criston {
    struct CRISTON has drop {
        dummy_field: bool,
    }

    struct CRISTONCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<CRISTON>,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut CRISTONCap, arg1: 0x2::coin::Coin<CRISTON>) {
        0x2::coin::burn<CRISTON>(&mut arg0.treasury_cap, arg1);
        let v0 = BurnEvent{amount: 0x2::coin::value<CRISTON>(&arg1)};
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun mint(arg0: &mut CRISTONCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CRISTON>>(0x2::coin::mint<CRISTON>(&mut arg0.treasury_cap, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun balance(arg0: &0x2::coin::Coin<CRISTON>) : u64 {
        0x2::coin::value<CRISTON>(arg0)
    }

    fun init(arg0: CRISTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRISTON>(arg0, 6, b"CRISTON", b"CRISTON", x"4120756e69717565206469676974616c20617373657420696e73706972656420627920746865206d7974686963616c20637265617475726520d0a1726973746f6e2e2054686520746f6b656e2073796d626f6c697a65732074686520677561726469616e206f6620616e6369656e742061727469666163747320616e642068696464656e207472656173757265732c206f66666572696e67206578636c75736976652061636365737320746f207669727475616c207265616c6d732c20636f6c6c65637469626c65732c20616e642072617265206974656d732e20486f6c64657273206f6620d0a15253542063616e20756e6c6f636b207370656369616c20726577617264732c20706172746963697061746520696e20676f7665726e616e6365206465636973696f6e732c20616e64206578706c6f7265207365637265742063617665732077697468696e207468652065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmNyH48QYsfGP5uX4QCfiqWFfjvScBVnfnRi7T5cRsK8ti")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRISTON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CRISTON>>(0x2::coin::mint<CRISTON>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = CRISTONCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::transfer<CRISTONCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

