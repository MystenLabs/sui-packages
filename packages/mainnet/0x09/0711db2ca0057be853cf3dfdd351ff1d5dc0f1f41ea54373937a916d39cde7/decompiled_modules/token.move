module 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct FaucetForTesting has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<TOKEN>,
    }

    public fun mint(arg0: &mut FaucetForTesting, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut arg0.treasury, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"TEST_TOKEN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        let v2 = FaucetForTesting{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<FaucetForTesting>(v2);
    }

    // decompiled from Move bytecode v6
}

