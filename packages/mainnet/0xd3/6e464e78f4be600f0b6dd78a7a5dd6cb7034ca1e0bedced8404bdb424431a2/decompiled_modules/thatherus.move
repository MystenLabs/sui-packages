module 0xd36e464e78f4be600f0b6dd78a7a5dd6cb7034ca1e0bedced8404bdb424431a2::thatherus {
    struct THATHERUS has drop {
        dummy_field: bool,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        remaining: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THATHERUS>, arg1: 0x2::coin::Coin<THATHERUS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<THATHERUS>(arg0, arg1);
    }

    public entry fun join(arg0: &mut 0x2::coin::Coin<THATHERUS>, arg1: 0x2::coin::Coin<THATHERUS>) {
        0x2::coin::join<THATHERUS>(arg0, arg1);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<THATHERUS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THATHERUS>>(0x2::coin::split<THATHERUS>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<THATHERUS>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THATHERUS>>(arg0, arg1);
    }

    public fun balance(arg0: &0x2::coin::Coin<THATHERUS>) : u64 {
        0x2::coin::value<THATHERUS>(arg0)
    }

    public fun get_actual_supply() : u64 {
        100000011000000000 - 100000011000000000 * 20 / 100
    }

    public fun get_burn_percentage() : u64 {
        20
    }

    public fun get_initial_supply() : u64 {
        100000011000000000
    }

    fun init(arg0: THATHERUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THATHERUS>(arg0, 9, b"tatbher", b"USDT ", x"74617462686572e4bba3e5b881202d205553445420202d20e983a8e7bdb2e697b6e99480e6af81323025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/usdt.png")), arg1);
        let v2 = v0;
        let v3 = 100000011000000000 * 20 / 100;
        let v4 = 100000011000000000 - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<THATHERUS>>(0x2::coin::mint<THATHERUS>(&mut v2, v4, arg1), 0x2::tx_context::sender(arg1));
        let v5 = BurnEvent{
            amount    : v3,
            remaining : v4,
        };
        0x2::event::emit<BurnEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THATHERUS>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THATHERUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

