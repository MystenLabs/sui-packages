module 0x8dcfd1623ea295d9da1c9593929e80947704b6bb28b9848a5b91ce98adf123ae::glooms {
    struct GLOOMS has drop {
        dummy_field: bool,
    }

    struct GLOOMSCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<GLOOMS>,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut GLOOMSCap, arg1: 0x2::coin::Coin<GLOOMS>) {
        0x2::coin::burn<GLOOMS>(&mut arg0.treasury_cap, arg1);
        let v0 = BurnEvent{amount: 0x2::coin::value<GLOOMS>(&arg1)};
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun mint(arg0: &mut GLOOMSCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOOMS>>(0x2::coin::mint<GLOOMS>(&mut arg0.treasury_cap, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun balance(arg0: &0x2::coin::Coin<GLOOMS>) : u64 {
        0x2::coin::value<GLOOMS>(arg0)
    }

    fun init(arg0: GLOOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOMS>(arg0, 6, b"GLOOMS2", b"GLOOMS2", b"Gloom Gloom Gloom 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmY8oLfuXAzE9c1LKgaFAEsVNaektL4W82pLRDX4ChY1KZ")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOOMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOOMS>>(0x2::coin::mint<GLOOMS>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = GLOOMSCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::transfer<GLOOMSCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

