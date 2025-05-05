module 0x9c9ef18d889c48ff4037dd5e967251d8999a5e2da17bb634829167b48defacb9::lvd {
    struct LVD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LVD>, arg1: 0x2::coin::Coin<LVD>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LVD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LVD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LVD>>(0x2::coin::mint<LVD>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<LVD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LVD>>(arg0, arg1);
    }

    public entry fun burn_amount(arg0: &mut 0x2::coin::TreasuryCap<LVD>, arg1: &mut 0x2::coin::Coin<LVD>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LVD>(arg0, 0x2::coin::split<LVD>(arg1, arg2 * 1000000000, arg3));
    }

    public entry fun burn_exact_amount(arg0: &mut 0x2::coin::TreasuryCap<LVD>, arg1: &mut 0x2::coin::Coin<LVD>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LVD>(arg0, 0x2::coin::split<LVD>(arg1, arg2, arg3));
    }

    public entry fun freeze_object<T0: store + key>(arg0: &0x2::coin::TreasuryCap<LVD>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<T0>(arg1);
    }

    fun init(arg0: LVD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVD>(arg0, 9, b"LVD", b"But chi Token", b"But chi native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20220620/ourmid/pngtree-pink-cute-cat-icon-animal-png-yuri-png-image_5230763.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LVD>>(v1);
    }

    public entry fun mint_exact(arg0: &mut 0x2::coin::TreasuryCap<LVD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LVD>>(0x2::coin::mint<LVD>(arg0, arg1, arg3), arg2);
    }

    public entry fun share_object<T0: store + key>(arg0: &0x2::coin::TreasuryCap<LVD>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<T0>(arg1);
    }

    public entry fun transfer_amount(arg0: &mut 0x2::coin::Coin<LVD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LVD>>(0x2::coin::split<LVD>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

