module 0xac0955d107ba0e5dc8f498e80de256f526655d58b40f6c09e1d2c4b77dd9a18c::dolp {
    struct DOLP has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<DOLP>,
    }

    public fun mint(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_coin(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOLP>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun total_supply(arg0: &Faucet) : u64 {
        0x2::coin::total_supply<DOLP>(&arg0.cap)
    }

    fun init(arg0: DOLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLP>(arg0, 9, b"DOLP", b"Dolphin Test Coin", b"Test coin for dolphin-4D-pocket. No value. Anyone can mint up to 1,000 DOLP per transaction.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLP>>(v1);
        let v2 = Faucet{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    public fun max_mint_per_tx() : u64 {
        1000000000000
    }

    public fun mint_coin(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DOLP> {
        assert!(arg1 <= 1000000000000, 0);
        0x2::coin::mint<DOLP>(&mut arg0.cap, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

