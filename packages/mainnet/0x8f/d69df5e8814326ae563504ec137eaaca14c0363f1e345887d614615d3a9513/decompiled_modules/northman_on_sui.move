module 0x8fd69df5e8814326ae563504ec137eaaca14c0363f1e345887d614615d3a9513::northman_on_sui {
    struct NORTHMAN_ON_SUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NORTHMAN_ON_SUI>, arg1: 0x2::coin::Coin<NORTHMAN_ON_SUI>) {
        0x2::coin::burn<NORTHMAN_ON_SUI>(arg0, arg1);
    }

    fun init(arg0: NORTHMAN_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORTHMAN_ON_SUI>(arg0, 9, b"NORTHMAN", b"Northman on SUI", b"In a realm of crypto warriors, SUI Northman Token reigns supreme. Forged in the frozen tundras of the North, this token embodies the resilience and strength of the legendary Vikings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/2K680dY/photo-2024-10-03-20-01-01.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NORTHMAN_ON_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORTHMAN_ON_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NORTHMAN_ON_SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NORTHMAN_ON_SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

