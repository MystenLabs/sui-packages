module 0x4babc167331a05265255a5d42a77af9da083258d4d3f0d79a35f8020361e7f6f::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SUI>,
    }

    public entry fun mint(arg0: &mut MintCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI>>(0x2::coin::mint<SUI>(&mut arg0.cap, arg1, arg3), arg2);
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"Sui", b"The native token of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/26375/small/sui-ocean-sq.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        let v2 = MintCap{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<MintCap>(v2);
    }

    // decompiled from Move bytecode v7
}

