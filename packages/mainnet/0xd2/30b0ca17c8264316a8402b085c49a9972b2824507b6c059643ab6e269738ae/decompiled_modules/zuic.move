module 0xd230b0ca17c8264316a8402b085c49a9972b2824507b6c059643ab6e269738ae::zuic {
    struct ZUIC has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CoinStore has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<ZUIC>,
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ZUIC>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZUIC>>(0x2::coin::mint<ZUIC>(arg1, arg2, arg4), arg3);
    }

    public fun claimToken(arg0: &mut CoinStore, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<ZUIC>(&arg0.balance) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZUIC>>(0x2::coin::take<ZUIC>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun creditTokens(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ZUIC>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2);
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ZUIC>>(0x2::coin::mint<ZUIC>(arg1, 0x1::vector::pop_back<u64>(&mut arg3), arg4), 0x1::vector::pop_back<address>(&mut arg2));
            v1 = v1 + 1;
        };
    }

    public fun debitToken(arg0: &mut CoinStore, arg1: &mut 0x2::coin::Coin<ZUIC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<ZUIC>(&mut arg0.balance, 0x2::balance::split<ZUIC>(0x2::coin::balance_mut<ZUIC>(arg1), arg2));
    }

    fun init(arg0: ZUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUIC>(arg0, 9, b"ZUIC", b"ZUIC", b"ZUIC COIN is platform token for ZUIC ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.svgrepo.com/show/33322/dollar-coin.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUIC>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = CoinStore{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<ZUIC>(),
        };
        0x2::transfer::share_object<CoinStore>(v3);
    }

    // decompiled from Move bytecode v6
}

