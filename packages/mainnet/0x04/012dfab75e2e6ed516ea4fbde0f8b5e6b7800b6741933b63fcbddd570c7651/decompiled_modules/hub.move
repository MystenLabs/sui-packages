module 0x4012dfab75e2e6ed516ea4fbde0f8b5e6b7800b6741933b63fcbddd570c7651::hub {
    struct HUB has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HUB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HUB>>(0x2::coin::mint<HUB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUB>(arg0, 8, b"HUB", b"Sui Hub Lagos", b"Coin Created at Sui Hub 24-06-2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.unsplash.com/photo-1749587452499-ea1fd591e63f?q=80&w=1656&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

