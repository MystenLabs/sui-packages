module 0xae14524982f93238f14e47de2d01a7002791e5e7507ba7126bc617cd34901877::tipusd {
    struct TIPUSD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TIPUSD>, arg1: 0x2::coin::Coin<TIPUSD>) {
        0x2::coin::burn<TIPUSD>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TIPUSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TIPUSD>>(0x2::coin::mint<TIPUSD>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<TIPUSD>) : u64 {
        0x2::coin::total_supply<TIPUSD>(arg0)
    }

    fun init(arg0: TIPUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPUSD>(arg0, 6, b"TIPUSD", b"TipUSD", b"StableLayer BrandUSD for CreatorVault - A yield-generating stablecoin for creator tips", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIPUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

