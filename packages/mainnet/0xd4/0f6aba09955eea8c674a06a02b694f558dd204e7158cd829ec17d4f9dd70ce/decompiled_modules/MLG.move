module 0xd40f6aba09955eea8c674a06a02b694f558dd204e7158cd829ec17d4f9dd70ce::MLG {
    struct MLG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MLG>, arg1: 0x2::coin::Coin<MLG>) {
        0x2::coin::burn<MLG>(arg0, arg1);
    }

    fun init(arg0: MLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLG>(arg0, 9, b"MLG", b"Major League Gaming", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/MPS3X1L/mlg.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MLG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MLG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

